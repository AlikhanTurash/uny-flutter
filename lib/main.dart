import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/app/app.dart';
import 'package:unyapp/data/implementation/uny_api.dart';
import 'package:unyapp/logic/reg_screen/auth_cubit.dart';
import 'package:unyapp/logic/reg_screen/reauth_cubit.dart';
import 'package:unyapp/logic/reg_screen/reg_screen_provider.dart';
import 'package:unyapp/logic/reg_screen/update_gender_cubit.dart';
import 'package:unyapp/logic/reg_screen/update_main_info_cubit.dart';
import 'package:unyapp/logic/reg_screen_interests/add_interest_cubit.dart';
import 'package:unyapp/logic/reg_screen_interests/delete_interest_cubit.dart';
import 'package:unyapp/logic/reg_screen_interests/interests_cubit.dart';
import 'package:unyapp/logic/reg_screen_interests/reg_screen_interests_provider.dart';
import 'package:unyapp/models/uny_user.dart';
import 'logic/reg_screen/login_cubit.dart';

//=========================
// Пользователь приложения
UnyUser? unyUser;
//=========================

void main() async {
  //-------
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  //-------

  // Пока пользователя нет
  unyUser = null;

  // Создаем API для инъектирования в кубиты
  final unyApi = UnyApi();

  //-------
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegScreenProvider()),
        ChangeNotifierProvider(create: (_) => RegScreenInterestsProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit(unyApi: unyApi)),
          BlocProvider(create: (_) => LoginCubit(unyApi: unyApi)),
          BlocProvider(create: (_) => ReAuthCubit(unyApi: unyApi)),
          BlocProvider(create: (_) => UpdateGenderCubit(unyApi: unyApi)),
          BlocProvider(create: (_) => UpdateMainInfoCubit(unyApi: unyApi)),
          BlocProvider(create: (_) => InterestsCubit(unyApi: unyApi)),
          BlocProvider(create: (_) => AddInterestCubit(unyApi: unyApi)),
          BlocProvider(create: (_) => DeleteInterestCubit(unyApi: unyApi)),
        ],
        child: App(),
      ),
    ),
  );
  //-------
}
