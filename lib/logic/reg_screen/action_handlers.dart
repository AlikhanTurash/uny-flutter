import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/app/routes.dart';
import 'package:unyapp/logic/reg_screen/auth_cubit.dart';
import 'package:unyapp/logic/reg_screen/login_cubit.dart';
import 'package:unyapp/logic/reg_screen/reauth_cubit.dart';
import 'package:unyapp/logic/reg_screen/reg_screen_provider.dart';
import 'package:unyapp/logic/reg_screen/update_gender_cubit.dart';
import 'package:unyapp/logic/reg_screen/update_main_info_cubit.dart';
import 'package:unyapp/logic/reg_screen/utils.dart';
import 'package:unyapp/models/gender.dart';

//---------------
// Экран "Привет"

abstract class RegScreenPhoneActions {
  //---
  // Изменение текста в поле ввода телефона
  static void phoneTextChanged(BuildContext context, String value) {
    context.read<RegScreenProvider>().setPhone(value);
  }

  //---
  // Нажатие на кнопку "Готово"
  static void doneButtonPress(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    final provider = Provider.of<RegScreenProvider>(context, listen: false);
    final phoneValidationMessage =
        validatePhone(provider.phone, provider.countryPhoneMask.digitsCount);
    if (phoneValidationMessage.isEmpty) {
      provider.setIsPhoneValid(true);
      final authCubit = BlocProvider.of<AuthCubit>(context, listen: false);
      authCubit.auth(
          countryCode: provider.countryPhoneMask.code, phone: onlyDigitsPhone(provider.phone));
    } else {
      provider.setIsPhoneValid(false);
      provider.setPhoneValidationMessage(phoneValidationMessage);
    }
  }

  //---
  // После успешной авторизации
  static void gotoSmsCodeScreen(BuildContext context) {
    context.pushNamed(ScreensNames.kRegScreenSmsCode);
  }
}

//-------------------
// Экран "Код из СМС"

abstract class RegScreenSmsCodeActions {
  //---
  // Нажатие на кнопку "Далее"
  static void smsDoneButtonPress(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    final provider = Provider.of<RegScreenProvider>(context, listen: false);
    final loginCubit = BlocProvider.of<LoginCubit>(context, listen: false);
    loginCubit.login(
      countryCode: provider.countryPhoneMask.code,
      phone: onlyDigitsPhone(provider.phone),
      smsCode: provider.smsCode,
    );
  }

  //---
  // После успешного ввода sms-кода (логина)
  static void gotoGenderInputScreen(BuildContext context) {
    //context.pushNamed(ScreensNames.kRegScreenGender);
    context.goNamed(ScreensNames.kRegScreenGender);
  }

  //---
  // Нажатие на "Отправить повторно"
  static void reAuthPress(BuildContext context) {
    final provider = Provider.of<RegScreenProvider>(context, listen: false);
    final reAuthCubit = BlocProvider.of<ReAuthCubit>(context, listen: false);
    reAuthCubit.auth(
        countryCode: provider.countryPhoneMask.code, phone: onlyDigitsPhone(provider.phone));
  }

  //---
  // Ошибка после "Отправить повторно" - заново инициализируем reAuthCubit
  static void resetAuthCubit(BuildContext context) {
    final reAuthCubit = BlocProvider.of<ReAuthCubit>(context, listen: false);
    Future.delayed(const Duration(milliseconds: 2500), () => reAuthCubit.toInitial());
  }
}

//-----------------------
// Экран "Укажи свой пол"

abstract class RegScreenGenderActions {
  //---
  // Нажатие на картинку выбора пола ("Женский", "Мужской", "Другое")
  static void setGender(BuildContext context, Gender gender) {
    final updateGenderCubit = BlocProvider.of<UpdateGenderCubit>(context, listen: false);
    updateGenderCubit.updateUser(gender: gender);
  }

  //---
  // После успешного выбора пола
  static void gotoMainInfoInputScreen(BuildContext context) {
    final updateGenderCubit = BlocProvider.of<UpdateGenderCubit>(context, listen: false);
    updateGenderCubit.toInitial();

    context.pushNamed(ScreensNames.kRegScreenMainInfo);
  }

  //---
  // Ошибка при выборе пола
  static void selectGenderErrorCallback(BuildContext context) {
    final updateGenderCubit = BlocProvider.of<UpdateGenderCubit>(context, listen: false);
    updateGenderCubit.toInitial();
  }
}

//------------------------
// Экран "Как тебя зовут?"

abstract class RegScreenMainInfoActions {
  //---
  // Нажатие на кнопку "Далее"
  static void nextButtonPress(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    final provider = Provider.of<RegScreenProvider>(context, listen: false);
    final firstNameValidationMessage = validateFirstName(provider.firstName);
    if (firstNameValidationMessage.isNotEmpty) {
      provider.setIsFirstNameValid(false);
      provider.setMainInfoValidationMessage(firstNameValidationMessage);
      return;
    }
    final lastNameValidationMessage = validateLastName(provider.lastName);
    if (lastNameValidationMessage.isNotEmpty) {
      provider.setIsLastNameValid(false);
      provider.setMainInfoValidationMessage(lastNameValidationMessage);
      return;
    }
    final dateOfBirthValidationMessage = validateDateOfBirth(provider.dateOfBirth);
    if (dateOfBirthValidationMessage.isNotEmpty) {
      provider.setIsDateOfBirthValid(false);
      provider.setMainInfoValidationMessage(dateOfBirthValidationMessage);
      return;
    }
    final locationValidationMessage = validateLocation(provider.location);
    if (locationValidationMessage.isNotEmpty) {
      provider.setIsLocationValid(false);
      provider.setLocationValidationMessage(locationValidationMessage);
      return;
    }
    //---
    // Валидация пройдена - отправляем данные на бэкенд
    final updateMainInfoCubit = BlocProvider.of<UpdateMainInfoCubit>(context, listen: false);
    updateMainInfoCubit.updateUser(
      firstName: provider.firstName,
      lastName: provider.lastName,
      dateOfBirth: provider.dateOfBirth,
      location: provider.location,
    );
  }

  //---
  // После успешного обновления данных пользователя
  static void gotoAddPhotosScreen(BuildContext context) {
    final updateMainInfoCubit = BlocProvider.of<UpdateMainInfoCubit>(context, listen: false);
    updateMainInfoCubit.toInitial();
    context.goNamed(ScreensNames.kRegScreenPhotos);
  }
}
