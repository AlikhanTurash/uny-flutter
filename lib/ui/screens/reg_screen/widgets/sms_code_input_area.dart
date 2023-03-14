import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/logic/reg_screen/reg_screen_provider.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';

class SmsCodeInputArea extends StatefulWidget {
  const SmsCodeInputArea({super.key});

  @override
  State<SmsCodeInputArea> createState() => _SmsCodeInputAreaState();
}

class _SmsCodeInputAreaState extends State<SmsCodeInputArea> {
  @override
  Widget build(BuildContext context) {
    final isCodeWrong =
        context.select<RegScreenProvider, bool>((provider) => provider.isSmsCodeWrong);

    final provider = Provider.of<RegScreenProvider>(context, listen: false);

    const cellsPadding = 12;
    final kErrorColor = Colors.red.shade400;
    const kRegularColor = Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(children: const [Text('Введите код', style: kInputAreaCaptionTextStyle)]),
        const SizedBox(height: 4),
        VerificationCode(
          underlineColor: isCodeWrong ? kErrorColor : kRegularColor,
          cursorColor: isCodeWrong ? kErrorColor : kRegularColor,
          digitsOnly: true,
          keyboardType: TextInputType.number,
          textStyle: TextStyle(
            fontSize: 25,
            color: isCodeWrong ? kErrorColor : kRegularColor,
          ),
          length: 4,
          itemSize: (MediaQuery.of(context).size.width - 2 * kHorizPadding - 3 * cellsPadding) / 4,
          underlineWidth: 2,
          underlineUnfocusedColor: isCodeWrong ? kErrorColor : kRegularColor.withOpacity(0.35),
          onCompleted: (value) => provider.setSmsCode(value),
          onEditing: (isEditing) {
            if (isEditing) {
              provider
                ..setSmsCode('')
                ..setIsSmsCodeWrong(false);
            }
          },
        ),
      ],
    );
  }
}
