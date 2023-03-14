import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';
import 'package:unyapp/models/interest.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/const.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final curCategoryId = context.select<RegScreenInterestsProvider, int>((pr) => pr.curCategoryId);
    final selectedInterests =
        context.select<RegScreenInterestsProvider, List<Interest>>((pr) => pr.selectedInterests);

    final count = selectedInterests.where((element) => element.categoryId == curCategoryId).length;
    final isEnabled = (count > 0);

    return GestureDetector(
      onTap: () {
        if (!isEnabled) return;
        final provider = Provider.of<RegScreenInterestsProvider>(context, listen: false);
        provider.setCurCategoryId(curCategoryId + 1);
        FocusManager.instance.primaryFocus?.unfocus();
        provider.setSearchString('');
      },
      child: Transform.translate(
        offset: const Offset(0, -1),
        child: Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                isEnabled ? const Color.fromRGBO(134, 32, 248, 1) : kGreyColor,
                isEnabled ? const Color.fromRGBO(57, 171, 223, 1) : kGreyColor
              ],
            ),
          ),
          child: Center(
            child: Transform.translate(
              offset: const Offset(3.5, -0.5),
              child: const Text('Далее',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
