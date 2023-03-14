import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/data/categories.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';
import 'package:unyapp/models/interest.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/const.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/category_avatar.dart';
import 'package:unyapp/ui/utils.dart';
import 'categories_horz_divider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final _scrollController = ScrollController();
  int _curCategoryId = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  static const kGap = SizedBox(width: 7);
  static const kGap2 = SizedBox(width: 9);
  static const kDivider = [kGap, CategoriesHorzDivider(), kGap2];

  //-------------
  List<Widget> _buildCategories(List<Interest> selectedInterests) {
    Map<int, int> categoryInterestsCount = {};
    for (var element in unyCategories) {
      categoryInterestsCount[element.id] = 0;
    }
    for (var interest in selectedInterests) {
      final catId = interest.categoryId;
      if (categoryInterestsCount[catId] != null) {
        categoryInterestsCount[catId] = categoryInterestsCount[catId]! + 1;
      }
    }

    List<Widget> widgetsList = [];
    for (var i = 0; i < unyCategories.length; i++) {
      if (i > 0) {
        for (var element in kDivider) {
          widgetsList.add(element);
        }
      }
      bool isLocked = categoryInterestsCount[unyCategories[i].id] == 0;
      widgetsList.add(
        CategoryAvatar(
          isLocked: isLocked,
          bgColor: unyCategories[i].mainColor,
          circleColor: isLocked
              ? unyCategories[i].mainColor.withOpacity(0.5)
              : darken(unyCategories[i].mainColor, 20),
          isShowCircle: ((unyCategories[i].id == _curCategoryId) || (i == 0) || !isLocked),
        ),
      );
      widgetsList.add(kGap);
      widgetsList.add(const SizedBox(width: 1));
      widgetsList.add(
        Text(
          unyCategories[i].name,
          style: (categoryInterestsCount[unyCategories[i].id] == 0)
              ? kCategoryTextStyle
              : kActiveCategoryTextStyle,
        ),
      );
    }
    return widgetsList;
  }

  //-------------
  void _scrollToCurCategory() {
    final index = unyCategories.indexWhere((el) => el.id == _curCategoryId);
    if (index < 2) return;
    try {
      //print('Скроллим до ${unyCategories[index - 1].name}');
      double w = 0;
      switch (index) {
        case 2:
          w = 152;
          break;
        case 3:
          w = 323;
          break;
        case 4:
        case 5:
          w = 999;
          break;
      }
      _scrollController.animateTo(
        w,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } catch (_) {}
  }
  //-------------

  @override
  Widget build(BuildContext context) {
    final curCategoryId = context.select<RegScreenInterestsProvider, int>((pr) => pr.curCategoryId);
    final selectedInterests =
        context.select<RegScreenInterestsProvider, List<Interest>>((pr) => pr.selectedInterests);

    if (_curCategoryId != curCategoryId) {
      _curCategoryId = curCategoryId;
      _scrollToCurCategory();
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizPadding + 1, vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _buildCategories(selectedInterests),
            ),
          ),
        ),
        /*
        Positioned(
          top: 0,
          child: GestureDetector(
            onTap: () {
              final index = 3;
              print('Скроллим до ${unyCategories[index - 1].name}');

              double w = 0;
              switch (index) {
                case 2:
                  w = 152;
                  break;
                case 3:
                  w = 323;
                  break;
                case 4:
                case 5:
                  w = 999;
                  break;
              }
              _scrollController.animateTo(
                w,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            child: Container(
              color: Colors.green,
              width: 15,
              height: 15,
            ),
          ),
        ),
        Positioned(
          top: 17,
          child: GestureDetector(
            onTap: () {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            child: Container(
              color: Colors.red,
              width: 15,
              height: 15,
            ),
          ),
        ), */
      ],
    );
  }
}
