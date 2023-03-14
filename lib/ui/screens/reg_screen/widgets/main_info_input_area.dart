import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/logic/reg_screen/reg_screen_provider.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';

class MainInfoInputArea extends StatefulWidget {
  const MainInfoInputArea({super.key});

  @override
  State<MainInfoInputArea> createState() => _MainInfoInputAreaState();
}

class _MainInfoInputAreaState extends State<MainInfoInputArea> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  DateTime? _selectedDateOfBirth;

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFirstNameValid =
        context.select<RegScreenProvider, bool>((provider) => provider.isFirstNameValid);

    final isLastNameValid =
        context.select<RegScreenProvider, bool>((provider) => provider.isLastNameValid);

    final isDateOfBirthValid =
        context.select<RegScreenProvider, bool>((provider) => provider.isDateOfBirthValid);

    final provider = Provider.of<RegScreenProvider>(context, listen: false);

    final kTextInputFormatters = [
      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\u0401\u0451\u0410-\u044f/g]")),
      FilteringTextInputFormatter.deny(RegExp("/"))
    ];

    return Column(
      children: [
        TextFormField(
          controller: _firstNameTextController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.done,
          style: kTextInputTextStyle,
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: kTextInputFormatters,
          maxLength: 40,
          decoration: isFirstNameValid
              ? kTextInputDecoration.copyWith(hintText: 'Имя')
              : kTextInputDecorationError.copyWith(hintText: 'Имя'),
          onChanged: (value) {
            provider.setIsFirstNameValid(true);
            provider.setFirstName(value);
          },
          onFieldSubmitted: ((value) {}),
        ),
        const SizedBox(height: 13),
        TextFormField(
          controller: _lastNameTextController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.done,
          style: kTextInputTextStyle,
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: kTextInputFormatters,
          maxLength: 40,
          decoration: isLastNameValid
              ? kTextInputDecoration.copyWith(hintText: 'Фамилия')
              : kTextInputDecorationError.copyWith(hintText: 'Фамилия'),
          onChanged: (value) {
            provider.setIsLastNameValid(true);
            provider.setLastName(value);
          },
          onFieldSubmitted: ((value) {}),
        ),
        const SizedBox(height: 13),
        GestureDetector(
          onTap: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            provider.setIsDateOfBirthValid(true);
            //---
            final datePicked = await DatePicker.showSimpleDatePicker(
              context,
              titleText: 'Дата рождения',
              initialDate: (_selectedDateOfBirth == null)
                  ? DateTime(DateTime.now().year - 20)
                  : _selectedDateOfBirth,
              firstDate: DateTime(DateTime.now().year - 100),
              lastDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
              dateFormat: "dd-MMMM-yyyy",
              locale: DateTimePickerLocale.ru,
              looping: true,
            );
            if (datePicked == null) {
              return;
            }
            setState(() {
              _selectedDateOfBirth = datePicked;
              provider.setDateOfBirth(datePicked);
            });
          },
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: isDateOfBirthValid
                ? kDateTimeDecoration
                : kDateTimeDecoration.copyWith(
                    border: kDateTimeDecorationErrorBorder,
                  ),
            child: Row(
              children: [
                const SizedBox(width: kInputLeftPadding - 2),
                (_selectedDateOfBirth == null)
                    ? Text('Дата рождения',
                        style: isDateOfBirthValid
                            ? kHintTextStyle
                            : kHintTextStyle.copyWith(color: kErrorTextColor))
                    : Text(DateFormat('dd.MM.yyyy').format(_selectedDateOfBirth!),
                        style: kTextInputTextStyle),
                const Spacer(),
                Icon(Icons.calendar_month, color: Colors.white.withOpacity(0.6), size: 26),
                const SizedBox(width: 11),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          child: (isFirstNameValid && isLastNameValid && isDateOfBirthValid)
              ? null
              : Row(
                  children: [
                    const SizedBox(width: 2),
                    const Icon(Icons.error, color: kErrorTextColor, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        provider.mainInfoValidationMessage,
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
