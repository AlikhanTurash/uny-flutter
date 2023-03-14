import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unyapp/logic/reg_screen/action_handlers.dart';
import 'package:unyapp/logic/reg_screen/reg_screen_provider.dart';
import 'package:unyapp/ui/screens/reg_screen/const.dart';
import 'package:unyapp/ui/screens/reg_screen/widgets/next_button_main_info_progress.dart';

class NextButtonMainInfo extends StatefulWidget {
  const NextButtonMainInfo({super.key});

  @override
  State<NextButtonMainInfo> createState() => _NextButtonMainInfoState();
}

class _NextButtonMainInfoState extends State<NextButtonMainInfo> {
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
                  child: const Center(child: Text('Далее', style: kDoneButtonTextStyle)),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: kDoneButtonBorderRadius,
                    child: InkWell(
                      borderRadius: kDoneButtonBorderRadius,
                      onTap: () {
                        RegScreenMainInfoActions.nextButtonPress(context);
                        final p = Provider.of<RegScreenProvider>(context, listen: false);
                        if (p.isFirstNameValid &&
                            p.isLastNameValid &&
                            p.isDateOfBirthValid &&
                            p.isLocationValid) {
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
        NextButtonMainInfoProgress(
          successCallback: () => _setIndex(0),
          errorCallback: () => _setIndex(0),
        ),
      ],
    );
  }
}
