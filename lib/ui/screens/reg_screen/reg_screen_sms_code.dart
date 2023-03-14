import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/logic/reg_screen/reg_screen_provider.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/bottom_text_sms.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/next_button_sms.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/reg_back_button.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/resend_sms_code_countdown.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/sms_code_input_area.dart';
import 'package:unyapp/ui/utils.dart';

class RegScreenSmsCode extends StatelessWidget {
  const RegScreenSmsCode({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegScreenProvider>(context, listen: false);
    final fullPhoneNumber =
        '${provider.countryPhoneMask.code} ${provider.phone}'.replaceAll(' ', '\u{00A0}');

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
                height: isSmallScreen ? kTopPaddingStepScreenSmall : kTopPaddingStepScreen,
              ),
              const RegBackButton(),
              isSmallScreen
                  ? const SizedBox(height: kTopPaddingTitleStepScreenSmall)
                  : const SizedBox(height: kTopPaddingTitleStepScreen),
              const Text('Код из СМС', style: kBigTextStyle),
              const SizedBox(height: kBigTextBottomMargin),
              Text(
                'Мы отправили код на твой номер телефона $fullPhoneNumber',
                maxLines: 3,
                style: kSubTextStyle,
              ),
              const Spacer(flex: 1),
              const SmsCodeInputArea(),
              isSmallScreen ? const SizedBox(height: 3) : const SizedBox(height: 6),
              const ResendSmsCodeCountdown(),
              isSmallScreen ? const SizedBox(height: 29) : const SizedBox(height: 34),
              const NextButtonSms(),
              const Spacer(flex: 1),
              isSmallScreen ? const SizedBox(height: 70) : const SizedBox(height: 50),
              const BottomTextSms(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),

      //),
    );
  }
}
