import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:unyapp/data/categories.dart';
import 'package:unyapp/logic/reg_screen_interests/action_handlers.dart';
import 'package:unyapp/models/color_pair.dart';
import 'package:unyapp/models/interest.dart';
import 'package:unyapp/ui/utils.dart';

class InterestChip extends StatelessWidget {
  final Interest interest;
  final bool canClose;

  const InterestChip({super.key, required this.interest, this.canClose = false});

  Widget _interestContainer(BuildContext context, {required bool isShadow}) {
    ColorPair colorPair =
        const ColorPair(id: -1, startGradiendColor: Colors.green, stopGradiendColor: Colors.green);

    final category = unyCategories.firstWhere((el) => el.id == interest.categoryId);

    final k = interest.id % 10;
    if ([1, 4, 7, 0].contains(k)) colorPair = category.colors[0];
    if ([2, 5, 8].contains(k)) colorPair = category.colors[1];
    if ([3, 6, 9].contains(k)) colorPair = category.colors[2];

    final shadowColor = darken(colorPair.stopGradiendColor, 50);

    const kHeight = 39.0;
    return Container(
      constraints: const BoxConstraints(maxHeight: kHeight, minHeight: kHeight),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            isShadow ? shadowColor : colorPair.startGradiendColor,
            isShadow ? shadowColor : colorPair.stopGradiendColor,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (isShadow) return;
              // Проверка лимита интересов в категории
              final categoryError = RegScreenInterestsActions.categoryLimitErrorMessage(context);
              if (categoryError.isNotEmpty) {
                showTopSnackBar(
                  Overlay.of(context)!,
                  CustomSnackBar.error(
                      message: 'Превышен лимит интересов в одной категории:  $categoryError'),
                  animationDuration: const Duration(milliseconds: 500),
                  displayDuration: const Duration(milliseconds: 1500),
                );
                return;
              }
              RegScreenInterestsActions.interestChipOnTap(context, interest);
            },
            child: Text(
              interest.name,
              style: TextStyle(
                color: isShadow ? Colors.transparent : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (canClose)
            GestureDetector(
              onTap: () {
                if (isShadow) return;
                RegScreenInterestsActions.interestChipOnCloseIconTap(context, interest);
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(11, 0, 2, 0),
                color: colorPair.startGradiendColor.withOpacity(0.005),
                child: SvgPicture.asset('assets/icons/delete_interest.svg'),
              ),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: -3,
          right: -2,
          child: _interestContainer(context, isShadow: true),
        ),
        _interestContainer(context, isShadow: false),
      ],
    );
  }
}
