import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unyapp/app/routes.dart';

class App extends StatelessWidget {
  App({super.key});

  final _router = GoRouter(
    //initialLocation: '/${ScreensNames.kSplashScreen}',
    //initialLocation: '/${ScreensNames.kRegScreenPhone}',
    //initialLocation: '/${ScreensNames.kRegScreenPhotos}',
    initialLocation: '/${ScreensNames.kRegScreenPhotos}',
    routes: kUnyAppRoutes,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Uny',
      theme: ThemeData.light().copyWith(
        textTheme:
            ThemeData.light().textTheme.apply(fontFamily: 'SFProDisplay'),
        primaryTextTheme:
            ThemeData.light().textTheme.apply(fontFamily: 'SFProDisplay'),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
