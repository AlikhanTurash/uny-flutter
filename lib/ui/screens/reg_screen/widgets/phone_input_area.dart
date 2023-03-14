import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/data/constants.dart';
import 'package:unyapp/logic/reg_screen/action_handlers.dart';
import 'package:unyapp/logic/reg_screen/reg_screen_provider.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/select_country_dialog.dart';

class PhoneInputArea extends StatefulWidget {
  const PhoneInputArea({super.key});

  @override
  State<PhoneInputArea> createState() => _PhoneInputAreaState();
}

class _PhoneInputAreaState extends State<PhoneInputArea> {
  final phoneNumberTextController = MaskedTextController(mask: kCountryPhoneMasks[0].mask);
  final focusNode = FocusNode();

  @override
  void dispose() {
    phoneNumberTextController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPhoneValid =
        context.select<RegScreenProvider, bool>((provider) => provider.isPhoneValid);

    final provider = Provider.of<RegScreenProvider>(context, listen: false);
    phoneNumberTextController.mask = provider.countryPhoneMask.mask;

    return Column(
      children: [
        Row(
          children: [
            Text(
              'Номер телефона',
              style: isPhoneValid ? kInputAreaCaptionTextStyle : kInputAreaCaptionErrorTextStyle,
            ),
          ],
        ),
        const SizedBox(height: 3),
        TextField(
          controller: phoneNumberTextController,
          focusNode: focusNode,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          keyboardType: TextInputType.number,
          cursorColor: Colors.white,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            hintText: provider.countryPhoneMask.mask.replaceAll('0', 'X'),
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 18),
            prefixIcon: Text(
              '${provider.countryPhoneMask.code}  ',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            alignLabelWithHint: true,
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: GestureDetector(
              child: Stack(
                children: [
                  Container(
                    width: 50,
                    height: 18,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.white.withOpacity(0.25),
                        ),
                      ),
                      child: Flag.fromString(
                        provider.countryPhoneMask.abbreviation,
                        height: 18,
                        width: 23,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -6,
                    top: -7.5,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white.withOpacity(0.75),
                      size: 33,
                    ),
                  )
                ],
              ),
              onTap: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                await Future.delayed(const Duration(milliseconds: 100));
                // ignore: use_build_context_synchronously
                final result = await showSelectCountryDialog(context);
                if (result == null) {
                  return;
                }
                phoneNumberTextController.clear();
                // ignore: use_build_context_synchronously
                RegScreenPhoneActions.phoneTextChanged(context, '');
                provider.setCountryPhoneMask(result);
                provider.setIsPhoneValid(true);
                setState(() {});
              },
            ),
            suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 2),
            ),
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(focusNode);
          },
          onChanged: (value) => RegScreenPhoneActions.phoneTextChanged(context, value),
          onSubmitted: (value) => RegScreenPhoneActions.phoneTextChanged(context, value),
        ),
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          child: isPhoneValid
              ? null
              : Row(
                  children: [
                    const Icon(Icons.error, color: kErrorTextColor, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      provider.phoneValidationMessage,
                      style: const TextStyle(color: kErrorTextColor, fontSize: 17),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
