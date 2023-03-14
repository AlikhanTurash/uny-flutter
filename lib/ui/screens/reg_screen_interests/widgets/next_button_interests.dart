import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:unyapp/data/categories.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';
import 'package:unyapp/models/interest.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/const.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/show_tooltip_dialog.dart';

class NextButtonInterests extends StatefulWidget {
  const NextButtonInterests({super.key});

  @override
  State<NextButtonInterests> createState() => _NextButtonInterestsState();
}

class _NextButtonInterestsState extends State<NextButtonInterests> {
  int _index = 0;

  void _setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedInterests =
        context.select<RegScreenInterestsProvider, List<Interest>>((pr) => pr.selectedInterests);

    final allInterestsCount =
        context.select<RegScreenInterestsProvider, int>((pr) => pr.allInterests.length);

    Map<int, int> categoryInterestsCount = {};
    for (var cat in unyCategories) {
      categoryInterestsCount[cat.id] = 0;
    }
    for (var interest in selectedInterests) {
      final catId = interest.categoryId;
      if (categoryInterestsCount[catId] != null) {
        categoryInterestsCount[catId] = categoryInterestsCount[catId]! + 1;
      }
    }

    bool isEnabled = true;
    for (var el in categoryInterestsCount.entries) {
      if (el.value == 0) {
        isEnabled = false;
        break;
      }
    }

    return IndexedStack(
      index: _index,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: (allInterestsCount == 0) ? 0.5 : 1,
                  child: Container(
                    height: kNextButtonHeight,
                    width: kNextButtonWidth,
                    decoration: isEnabled ? kNextButtonDecoration : kNextButtonDecorationDisabled,
                    child: Center(
                      child: Text(
                        'Готово',
                        style: isEnabled ? kNextButtonTextStyle : kNextButtonTextStyleDisabled,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: kNextButtonBorderRadius,
                    child: InkWell(
                      borderRadius: kNextButtonBorderRadius,
                      onTap: (allInterestsCount == 0)
                          ? null
                          : () {
                              if (!isEnabled) {
                                if (allInterestsCount == 0) return;

                                showTopSnackBar(
                                  Overlay.of(context)!,
                                  const CustomSnackBar.error(
                                    message:
                                        'В каждой категории необходимо выбрать хотя бы один интерес',
                                  ),
                                  animationDuration: const Duration(milliseconds: 700),
                                  displayDuration: const Duration(milliseconds: 2000),
                                );

                                return;
                              }

                              // if (...) {
                              //   _setIndex(1);
                              // }
                            },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // NextButtonPhotosProgress(
        //   successCallback: () => _setIndex(0),
        //   errorCallback: () => _setIndex(0),
        // ),
      ],
    );
  }
}
