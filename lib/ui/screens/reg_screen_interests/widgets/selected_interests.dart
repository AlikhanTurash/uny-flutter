import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';
import 'package:unyapp/models/interest.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/const.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/widgets/interest_chip.dart';

class SelectedInterests extends StatelessWidget {
  const SelectedInterests({super.key});

  @override
  Widget build(BuildContext context) {
    final curCategoryId = context.select<RegScreenInterestsProvider, int>((pr) => pr.curCategoryId);
    final selectedInterests =
        context.select<RegScreenInterestsProvider, List<Interest>>((pr) => pr.selectedInterests);

    const kHeight = 78.0;

    if (selectedInterests.isEmpty) {
      return const SizedBox(
        height: kHeight,
        child: Center(
          child: Text('Выбери минимум один интерес\nв каждой категории',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.5, color: Colors.black45, letterSpacing: -0.15)),
        ),
      );
    }

    return SizedBox(
      height: kHeight,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizPadding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: selectedInterests.reversed
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(right: 11),
                    child:
                        InterestChip(interest: e, canClose: true /*e.categoryId == curCategoryId*/),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
