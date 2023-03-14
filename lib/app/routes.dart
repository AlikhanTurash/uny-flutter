import 'package:go_router/go_router.dart';
import 'package:unyapp/app/utils.dart';
import 'package:unyapp/ui/screens/reg_screen/reg_screen_gender.dart';
import 'package:unyapp/ui/screens/reg_screen/reg_screen_main_info.dart';
import 'package:unyapp/ui/screens/reg_screen/reg_screen_sms_code.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/reg_screen_interests.dart';
import 'package:unyapp/ui/screens/reg_screen_media/reg_screen_photos.dart';
import 'package:unyapp/ui/screens/splash_screen/splash_screen.dart';
import 'package:unyapp/ui/screens/reg_screen/reg_screen_phone.dart';

//---------
// Screens names
abstract class ScreensNames {
  // Сплэш ---
  static const kSplashScreen = 'splash_screen';

  // Регистрация ---
  static const kRegScreenPhone = 'reg_screen_phone';
  static const kRegScreenSmsCode = 'reg_screen_sms_code';
  static const kRegScreenGender = 'reg_screen_gender';
  static const kRegScreenMainInfo = 'reg_screen_main_info';

  // Регистрация: Фото/видео ---
  static const kRegScreenPhotos = 'reg_screen_photos';

  // Регистрация: Интересы ---
  static const kRegScreenInterests = 'reg_screen_interests';
}

//---------
// App Routes
final List<GoRoute> kUnyAppRoutes = [
  // Сплэш ---
  unyRoute(name: ScreensNames.kSplashScreen, builder: (_, __) => const SplashScreen()),

  // Регистрация ---
  unyRoute(name: ScreensNames.kRegScreenPhone, builder: (_, __) => const RegScreenPhone()),
  unyRoute(name: ScreensNames.kRegScreenSmsCode, builder: (_, __) => const RegScreenSmsCode()),
  unyRoute(name: ScreensNames.kRegScreenGender, builder: (_, __) => const RegScreenGender()),
  unyRoute(name: ScreensNames.kRegScreenMainInfo, builder: (_, __) => const RegScreenMainInfo()),

  // Регистрация: Фото/видео ---
  unyRoute(name: ScreensNames.kRegScreenPhotos, builder: (_, __) => const RegScreenPhotos()),

  // Регистрация: Интересы ---
  unyRoute(name: ScreensNames.kRegScreenInterests, builder: (_, __) => const RegScreenInterests()),
];
