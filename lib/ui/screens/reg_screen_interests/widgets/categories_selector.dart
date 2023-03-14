import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/data/categories.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';
import 'package:unyapp/models/category.dart';
import 'package:unyapp/models/interest.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/const.dart';
import 'package:unyapp/ui/utils.dart';

class CategoriesSelector extends StatefulWidget {
  const CategoriesSelector({super.key});

  @override
  State<CategoriesSelector> createState() => _CategoriesSelectorState();
}

class _CategoriesSelectorState extends State<CategoriesSelector> {
  //~~~~~~~
  Widget _categoryItem(Category item, int curCategoryId, List<Interest> selectedInterests) {
    final isSelected = (item.id == curCategoryId);
    final width = calcTextSize(item.name, kCategoryNameTextStyle).width;

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

    int catInterestsCount = 0;
    if ((categoryInterestsCount[item.id] != null) && (categoryInterestsCount[item.id]! > 0)) {
      catInterestsCount = categoryInterestsCount[item.id]!;
    }

    const kBorderRadius0 = 14.0;
    const kBorderRadius1 = 12.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 45,
          width: width + 48,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: isSelected ? item.mainColor : item.mainColor.withOpacity(0.15),
            borderRadius: (catInterestsCount > 0)
                ? const BorderRadius.only(
                    topLeft: Radius.circular(kBorderRadius1),
                    bottomLeft: Radius.circular(kBorderRadius1),
                    bottomRight: Radius.circular(kBorderRadius1),
                    topRight: Radius.circular(kBorderRadius1),
                  )
                : const BorderRadius.all(Radius.circular(kBorderRadius0)),
            border: Border.all(
              width: isSelected ? 3 : 1,
              color: isSelected ? darken(item.mainColor, 30) : item.mainColor.withOpacity(0.3),
            ),
          ),
          child: Center(
            child: Transform.translate(
              offset: const Offset(0, -0.7),
              child: Text(
                item.name,
                style: isSelected ? kSelectedCategoryNameTextStyle : kCategoryNameTextStyle,
              ),
            ),
          ),
        ),
        if (catInterestsCount > 0)
          Positioned(
            right: 16,
            top: 4,
            child: Text(
              categoryInterestsCount[item.id]!.toString(),
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Colors.white.withOpacity(0.8) /*darken(item.mainColor, 45)*/
                      //: item.mainColor.withOpacity(0.7),
                      : Colors.grey.shade800.withOpacity(0.45)),
            ),
          ),
      ],
    );
  }
  //~~~~~~~

  @override
  Widget build(BuildContext context) {
    final curCategoryId = context.select<RegScreenInterestsProvider, int>((pr) => pr.curCategoryId);
    final selectedInterests =
        context.select<RegScreenInterestsProvider, List<Interest>>((pr) => pr.selectedInterests);

    // print(curCategoryId);
    // if (curCategoryId == 0) {
    //   Future.delayed(const Duration(milliseconds: 50), () {
    //     final provider = Provider.of<RegScreenInterestsProvider>(context, listen: false);
    //     provider.setCurCategoryId(unyCategories[0].id);
    //   });
    // }

    return SingleChildScrollView(
      //controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizPadding + 1, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: unyCategories
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    final provider =
                        Provider.of<RegScreenInterestsProvider>(context, listen: false);
                    provider.setCurCategoryId(e.id);
                    FocusManager.instance.primaryFocus?.unfocus();
                    provider.setSearchString('');
                  },
                  child: _categoryItem(e, curCategoryId, selectedInterests),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
