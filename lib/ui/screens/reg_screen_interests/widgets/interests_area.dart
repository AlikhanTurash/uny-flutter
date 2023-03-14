import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';
import 'package:unyapp/models/interest.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/const.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/add_new_interest_button.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/interest_chip.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/show_tooltip_dialog.dart';

class InterestsArea extends StatefulWidget {
  const InterestsArea({super.key});

  @override
  State<InterestsArea> createState() => _InterestsAreaState();
}

class _InterestsAreaState extends State<InterestsArea> {
  final _controllerListView = ScrollController();
  final _controllerSingleChildScrollView = ScrollController();
  int _curCategoryId = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) {
          final provider = Provider.of<RegScreenInterestsProvider>(context, listen: false);
          if (!provider.tooltipWasShown) {
            provider.tooltipWasShown = true;
            // Показываем тултип
            showTooltipDialog(context);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _controllerListView.dispose();
    _controllerSingleChildScrollView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegScreenInterestsProvider>(context, listen: false);

    final curCategoryId = context.select<RegScreenInterestsProvider, int>((pr) => pr.curCategoryId);
    final searchString =
        context.select<RegScreenInterestsProvider, String>((pr) => pr.searchString);
    final selectedInterests =
        context.select<RegScreenInterestsProvider, List<Interest>>((pr) => pr.selectedInterests);

    /*
    final List<Interest> interests = provider.allInterests.where(
      (element) {
        if ((element.categoryId == curCategoryId) &&
            (selectedInterests.indexWhere((el) => el.id == element.id)) < 0) {
          if (searchString.isEmpty) return true;
          return element.name.toLowerCase().contains(searchString.trim().toLowerCase());
        }
        return false;
      },
    ).toList();
    */

    List<Interest> interests = [];

    //---
    if (searchString.isEmpty) {
      interests = provider.allInterests.where(
        (element) {
          if ((element.categoryId == curCategoryId) &&
              (selectedInterests.indexWhere((el) => el.id == element.id)) < 0) {
            return true;
          }
          return false;
        },
      ).toList();
    }
    //---
    else {
      // Строка поиска не пустая - ищем среди всех
      interests = provider.allInterests.where(
        (element) {
          if (element.name.toLowerCase().contains(searchString.trim().toLowerCase()) &&
              (selectedInterests.indexWhere((el) => el.id == element.id)) < 0) {
            return true;
          }
          return false;
        },
      ).toList();
    }
    //---

    //------------------
    // Не найдено ничего
    if (interests.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Text(
              'По твоему запросу не найдено подходящего интереса. Ты можешь добавить новый вручную.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.5, color: Colors.black54),
            ),
          ),
          SizedBox(height: 10),
          AddNewInterestButton()
        ],
      );
    }
    //-----------------

    /*
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.fromLTRB(kHorizPadding, 0, 10, 0),
        width: MediaQuery.of(context).size.width * 1.6,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            spacing: 11,
            runSpacing: 8.5,
            children: interests.map((e) => InterestChip(interest: e)).toList(),
          ),
        ),
      ),
    );
    */

    if (_curCategoryId != curCategoryId) {
      _curCategoryId = curCategoryId;
      try {
        _controllerListView.jumpTo(0);
        _controllerSingleChildScrollView.jumpTo(0);
      } catch (_) {}
    }

    const kChunkSize = 50;
    final kChunksCount = ((interests.length % kChunkSize) == 0)
        ? interests.length ~/ kChunkSize
        : (interests.length ~/ kChunkSize) + 1;

    final screenWidth = MediaQuery.of(context).size.width;
    final widgetWidth = (searchString.isNotEmpty) ? screenWidth - 7 : screenWidth * 1.6;

    return SingleChildScrollView(
      controller: _controllerSingleChildScrollView,
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.fromLTRB(kHorizPadding, 0, 10, 0),
        //width: MediaQuery.of(context).size.width * 1.6,
        width: widgetWidth,
        //color: Colors.amber[200],

        child: Stack(
          children: [
            ListView.builder(
              controller: _controllerListView,
              padding: EdgeInsets.zero,
              itemCount: kChunksCount,
              itemBuilder: (_, index) {
                final int startIndex = index * kChunkSize;
                int endIndex = index * kChunkSize + kChunkSize;
                if (endIndex >= interests.length) {
                  endIndex = interests.length - 1;
                }
                List<Interest> interestsChunk = interests.sublist(startIndex, endIndex);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.5),
                  child: WrapSuper(
                    spacing: 11,
                    lineSpacing: 8.5,
                    //wrapType: WrapType.balanced,
                    wrapType: (searchString.isNotEmpty) ? WrapType.fit : WrapType.balanced,
                    children: interestsChunk.map((e) => InterestChip(interest: e)).toList(),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 16,
                width: widgetWidth,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.white, Color.fromRGBO(255, 255, 255, 0)],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
