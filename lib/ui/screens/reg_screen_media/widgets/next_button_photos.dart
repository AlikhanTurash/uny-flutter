import 'package:flutter/material.dart';
import 'package:unyapp/ui/screens/reg_screen_media/const.dart';

class NextButtonPhotos extends StatefulWidget {
  final bool isEnabled;
  final void Function() onTap;

  const NextButtonPhotos({super.key, required this.onTap, required this.isEnabled});

  @override
  State<NextButtonPhotos> createState() => _NextButtonPhotosState();
}

class _NextButtonPhotosState extends State<NextButtonPhotos> {
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
                  height: kNextButtonHeight,
                  width: kNextButtonWidth,
                  decoration:
                      widget.isEnabled ? kNextButtonDecoration : kNextButtonDecorationDisabled,
                  child: Center(
                    child: Text(
                      'Далее',
                      style: widget.isEnabled ? kNextButtonTextStyle : kNextButtonTextStyleDisabled,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: kNextButtonBorderRadius,
                    child: InkWell(
                      borderRadius: kNextButtonBorderRadius,
                      onTap: () {
                        widget.onTap();
                        // RegScreenPhoneActions.doneButtonPress(context);
                        // final isPhoneValid = context.read<RegScreenProvider>().isPhoneValid;
                        // if (isPhoneValid) {
                        //   _setIndex(1);
                        // }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // NextButtonPhotosProgress(
        //   successCallback: () => _setIndex(0),
        //   errorCallback: () => _setIndex(0),
        // ),
      ],
    );
  }
}
