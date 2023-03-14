import 'package:flutter/material.dart';

class BottomTextPhone extends StatelessWidget {
  const BottomTextPhone({super.key});

  @override
  Widget build(BuildContext context) {
    const kLinkColor = Color(0xFF78BDFE);

    return const Text.rich(
      TextSpan(
          text: 'Нажимая "Готово", вы подтверждаете  ',
          style: TextStyle(color: Colors.white, fontSize: 16),
          children: [
            TextSpan(
                text: 'согласие с условиями использования UnyApp ',
                style: TextStyle(color: kLinkColor)),
            TextSpan(text: ' и  ', style: TextStyle(color: Colors.white)),
            TextSpan(
              text: 'политикой о данных пользователей',
              style: TextStyle(color: kLinkColor),
            )
          ]),
      textAlign: TextAlign.center,
    );
  }
}
