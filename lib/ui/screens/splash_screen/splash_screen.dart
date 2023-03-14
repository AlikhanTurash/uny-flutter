import 'package:flutter/material.dart';
import 'package:unyapp/logic/splash_screen/action_handlers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: SplashScreenActions.kSplashScreenDelay), () {
        SplashScreenActions.gotoRegScreen(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            SizedBox(
              width: 133,
              height: 133,
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(height: 30),
            const Text(
              'UNY',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 300,
              child: Text(
                'Ожидайте, мы ищем вам лучших людей...',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7E7E7E),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
