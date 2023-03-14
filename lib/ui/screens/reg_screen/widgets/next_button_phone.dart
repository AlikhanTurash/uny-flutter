import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/logic/reg_screen/action_handlers.dart';
import 'package:unyapp/logic/reg_screen/reg_screen_provider.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/next_button_phone_progress.dart';

class NextButtonPhone extends StatefulWidget {
  const NextButtonPhone({super.key});

  @override
  State<NextButtonPhone> createState() => _NextButtonPhoneState();
}

class _NextButtonPhoneState extends State<NextButtonPhone> {
  int _index = 0;

  void _setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  decoration: kDoneButtonDecoration,
                  child: const Center(child: Text('Готово!', style: kDoneButtonTextStyle)),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: kDoneButtonBorderRadius,
                    child: InkWell(
                      borderRadius: kDoneButtonBorderRadius,
                      onTap: () {
                        RegScreenPhoneActions.doneButtonPress(context);
                        final isPhoneValid = context.read<RegScreenProvider>().isPhoneValid;
                        if (isPhoneValid) {
                          _setIndex(1);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        NextButtonPhoneProgress(
          successCallback: () => _setIndex(0),
          errorCallback: () => _setIndex(0),
        ),
      ],
    );
  }
}
