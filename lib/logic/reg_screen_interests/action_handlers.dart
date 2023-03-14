import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/data/categories.dart';
import 'package:unyapp/logic/reg_screen_interests/add_interest_cubit.dart';
import 'package:unyapp/logic/reg_screen_interests/delete_interest_cubit.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';
import 'package:unyapp/models/interest.dart';

//---------------
// Экран выбора интересов

abstract class RegScreenInterestsActions {
  //---
  // Нажатие на InterestChip (выбор интереса)
  static void interestChipOnTap(BuildContext context, Interest interest) {
    // Добавляем в Selected только в случае успешной отработки кубита!
    // final provider = Provider.of<RegScreenInterestsProvider>(context, listen: false);
    // provider.addInterestToSelected(interest);
    //-------
    final addInterestCubit = BlocProvider.of<AddInterestCubit>(context, listen: false);
    addInterestCubit.addInterestToUser(interest.id);
  }

  //---
  // Нажатие на иконку "закрыть" InterestChip (удаление интереса из выбранных)
  static void interestChipOnCloseIconTap(BuildContext context, Interest interest) {
    // final provider = Provider.of<RegScreenInterestsProvider>(context, listen: false);
    // provider.removeInterestFromSelected(interest);
    //-------
    final deleteInterestCubit = BlocProvider.of<DeleteInterestCubit>(context, listen: false);
    deleteInterestCubit.deleteInterestFromUser(interest.id);
  }

  //---
  // Проверка превышения лимита интересов в категории
  static String categoryLimitErrorMessage(BuildContext context) {
    final provider = Provider.of<RegScreenInterestsProvider>(context, listen: false);
    final curCategoryId = provider.curCategoryId;
    int count = 0;
    for (var el in provider.selectedInterests) {
      if (el.categoryId == curCategoryId) count++;
    }
    if (count < 20) return '';
    final categoryName = unyCategories.firstWhere((el) => el.id == curCategoryId).name;
    return '"$categoryName"  ($count интересов)';
  }
}
