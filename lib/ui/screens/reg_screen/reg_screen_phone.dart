import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/bottom_text_phone.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/next_button_phone.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/phone_input_area.dart';
import 'package:unyapp/ui/utils.dart';

class RegScreenPhone extends StatelessWidget {
  const RegScreenPhone({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = isPhoneScreenSmall(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: kScreenDecoration,
          padding: const EdgeInsets.symmetric(horizontal: kHorizPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: isSmallScreen ? kTopPaddingSmall : kTopPadding,
              ),
              const Text('Привет! 👋', style: kBigTextStyle),
              const SizedBox(height: kBigTextBottomMargin),
              Text(
                'Введи номер телефона, чтобы войти или зарегистрироваться, если ты новенький!',
                maxLines: 3,
                style: kSubTextStyle,
              ),
              const Spacer(flex: 1),
              const PhoneInputArea(),
              isSmallScreen ? const SizedBox(height: 15) : const SizedBox(height: 30),
              const NextButtonPhone(),
              const Spacer(flex: 1),
              const BottomTextPhone(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
