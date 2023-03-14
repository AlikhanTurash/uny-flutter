import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:unyapp/data/constants.dart';
import 'package:unyapp/models/country_phone_mask.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';

//---
// Диалог выбора страны на экране ввода телефона

Future<CountryPhoneMask?> showSelectCountryDialog(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  const kCountryTextStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.w500);
  return showDialog<CountryPhoneMask>(
    context: context,
    barrierColor: kBarrierColor,
    builder: (context) => AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: kHorizPadding * 2, vertical: screenHeight / 5),
      titlePadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      title: const SizedBox(
        width: 260,
        child: Padding(
          padding: EdgeInsets.only(bottom: 7),
          child: Text(
            'Выберите страну из списка',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...kCountryPhoneMasks.map((item) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pop(item),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    children: [
                      const SizedBox(width: 3),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            width: 1,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        child: Flag.fromString(item.abbreviation,
                            height: 19, width: 27, fit: BoxFit.fill),
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: 66,
                        child: Text(item.code, style: kCountryTextStyle),
                      ),
                      Expanded(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Text(
                            item.countryName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kCountryTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}
