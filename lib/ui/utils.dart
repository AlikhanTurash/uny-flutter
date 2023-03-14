import 'package:flutter/material.dart';

bool isPhoneScreenSmall(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  return (height < 750);
}

// ........................................................
// Darken a color by [percent] amount (100 = black)
Color darken(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var f = 1 - percent / 100;
  return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(), (c.blue * f).round());
}

// Lighten a color by [percent] amount (100 = white)
Color lighten(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var p = percent / 100;
  return Color.fromARGB(c.alpha, c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(), c.blue + ((255 - c.blue) * p).round());
}
// ........................................................

Size calcTextSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
    textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
  )..layout();
  return textPainter.size;
}
