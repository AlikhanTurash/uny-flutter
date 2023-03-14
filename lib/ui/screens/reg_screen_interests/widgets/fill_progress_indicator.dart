import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/data/categories.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';

class FillProgressIndicator extends StatelessWidget {
  final double width;

  const FillProgressIndicator({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedInterestsCount =
        context.select<RegScreenInterestsProvider, int>((pr) => pr.selectedInterests.length);

    final curCategoryId = context.select<RegScreenInterestsProvider, int>((pr) => pr.curCategoryId);

    Color color;
    if (unyCategories.indexWhere((el) => el.id == curCategoryId) < 0) {
      color = Colors.grey;
    } else {
      color = unyCategories.firstWhere((el) => el.id == curCategoryId).mainColor;
    }

    const kHeight = 26.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(kHeight),
      child: Stack(
        children: [
          Container(
            height: kHeight,
            width: width,
            color: color.withOpacity(0.13),
          ),
          //Positioned(child: Container)
          Container(
            height: kHeight,
            width: width * selectedInterestsCount / 100,
            color: color,
          ),
          if (selectedInterestsCount > 0)
            Positioned(
              right: 12.5,
              top: 3,
              child: Text(
                selectedInterestsCount.toString(),
                style: TextStyle(
                  fontSize: 15.6,
                  fontWeight: FontWeight.bold,
                  color: (selectedInterestsCount < 80) ? color : Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
