import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unyapp/ui/screens/reg_screen_interests/const.dart';

class CategoryAvatar extends StatelessWidget {
  final bool isLocked;
  final Color? bgColor;
  final bool isShowCircle;
  final Color? circleColor;

  const CategoryAvatar(
      {super.key,
      required this.isLocked,
      this.bgColor,
      required this.isShowCircle,
      this.circleColor});

  @override
  Widget build(BuildContext context) {
    const kLockBgColor = Color.fromRGBO(237, 237, 237, 1);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -2.7,
          left: -2.7,
          child: CircleAvatar(
            backgroundColor: isShowCircle ? circleColor ?? Colors.transparent : Colors.transparent,
            radius: 18.6,
          ),
        ),
        CircleAvatar(
          backgroundColor: isLocked ? kLockBgColor : (bgColor ?? kLockBgColor),
          radius: 16,
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: SvgPicture.asset(
              isLocked ? 'assets/icons/lock.svg' : 'assets/icons/lock_open.svg',
              color: isLocked ? kGreyColor : Colors.white,
              width: 14,
              height: 14,
            ),
          ),
        ),
      ],
    );
  }
}
