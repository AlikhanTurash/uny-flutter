import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/logic/reg_screen/reg_screen_provider.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';

class CityInputArea extends StatefulWidget {
  final bool isSmallScreen;

  const CityInputArea({Key? key, required this.isSmallScreen}) : super(key: key);

  @override
  State<CityInputArea> createState() => _CityInputAreaState();
}

class _CityInputAreaState extends State<CityInputArea> {
  final _cityTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLocationValid =
        context.select<RegScreenProvider, bool>((provider) => provider.isLocationValid);

    final provider = Provider.of<RegScreenProvider>(context, listen: false);

    return Column(
      children: [
        TextFormField(
          controller: _cityTextController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.done,
          style: kTextInputTextStyle,
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: const [],
          maxLength: 100,
          decoration: kTextInputDecoration.copyWith(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Icon(
                Icons.search,
                color: Colors.white.withOpacity(0.7),
                size: 22,
              ),
            ),
            hintText: 'Название города',
            enabledBorder: isLocationValid
                ? kTextInputDecoration.enabledBorder
                : kTextInputDecoration.enabledBorder!.copyWith(
                    borderSide: const BorderSide(color: kErrorTextColor, width: 3),
                  ),
            focusedBorder: isLocationValid
                ? kTextInputDecoration.focusedBorder
                : kTextInputDecoration.focusedBorder!.copyWith(
                    borderSide: const BorderSide(color: kErrorTextColor, width: 3),
                  ),
          ),
          onChanged: (value) {
            provider.setIsLocationValid(true);
            provider.setLocation(value);
          },
          onFieldSubmitted: ((value) {}),
        ),
        SizedBox(
          height: widget.isSmallScreen ? 34 : 37,
          child: isLocationValid
              ? null
              : Row(
                  children: [
                    const SizedBox(width: 2),
                    const Icon(Icons.error, color: kErrorTextColor, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        provider.locationValidationMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: kErrorTextColor, fontSize: 17),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
