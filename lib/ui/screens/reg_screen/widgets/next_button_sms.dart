import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/logic/reg_screen/action_handlers.dart';
import 'package:unyapp/logic/reg_screen/reg_screen_provider.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/next_button_sms_progress.dart';

class NextButtonSms extends StatefulWidget {
  const NextButtonSms({super.key});

  @override
  State<NextButtonSms> createState() => _NextButtonSmsState();
}

class _NextButtonSmsState extends State<NextButtonSms> {
  int _index = 0;

  void _setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmsCodeWrong =
        context.select<RegScreenProvider, bool>((provider) => provider.isSmsCodeWrong);
    final smsCode = context.select<RegScreenProvider, String>((provider) => provider.smsCode);

    final isButtonDisabled = ((smsCode.length != 4) || isSmsCodeWrong);

    return IndexedStack(
      index: _index,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: kDoneButtonHeight,
                  width: kDoneButtonWidth,
                  decoration:
                      isButtonDisabled ? kDoneButtonDecorationDisabled : kDoneButtonDecoration,
                  child: Center(
                    child: Text(
                      'Далее',
                      style: isButtonDisabled ? kDoneButtonTextStyleDisabled : kDoneButtonTextStyle,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: kDoneButtonBorderRadius,
                    child: InkWell(
                      borderRadius: kDoneButtonBorderRadius,
                      onTap: isButtonDisabled
                          ? null
                          : () {
                              RegScreenSmsCodeActions.smsDoneButtonPress(context);
                              _setIndex(1);
                            },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        NextButtonSmsProgress(
          successCallback: () => _setIndex(0),
          errorCallback: () => _setIndex(0),
        ),
      ],
    );
  }
}
