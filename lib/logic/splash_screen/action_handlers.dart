import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:unyapp/app/routes.dart';

abstract class SplashScreenActions {
  //---
  // Сколько миллисекунд показываем сплэш
  static const kSplashScreenDelay = 1700;

  //---
  // Переход на экран регистрации
  static void gotoRegScreen(BuildContext context) {
    context.goNamed(ScreensNames.kRegScreenPhone);
  }
}
