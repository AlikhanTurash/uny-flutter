import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomTextSms extends StatelessWidget {
  const BottomTextSms({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SvgPicture.asset('assets/icons/assistance.svg'),
        const SizedBox(width: 9),
        const Text.rich(
          TextSpan(
              text: 'Не приходит код?  ',
              style: TextStyle(color: Colors.white, fontSize: 17),
              children: [
                TextSpan(
                  text: 'Мы поможем!',
                  style: TextStyle(
                      color: Colors.white, fontSize: 17, decoration: TextDecoration.underline),
                ),
              ]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
