import 'package:flutter/material.dart';

const kStartGradientColor = Color.fromRGBO(165, 21, 215, 5);
const kStopGradientColor = Color.fromRGBO(38, 78, 215, 5);

const kHorizPadding = 18.0;

const kBigTextStyle = TextStyle(
  fontSize: 28,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const kBigTextBottomMargin = 8.0;

final kSubTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.white.withOpacity(0.6),
);

const kTopPadding = 100.0;
const kTopPaddingSmall = 76.0;

const kTopPaddingStepScreen = 41.0;
const kTopPaddingStepScreenSmall = 34.0;

const kTopPaddingTitleStepScreen = 11.0;
const kTopPaddingTitleStepScreenSmall = 4.0;

const kScreenDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kStartGradientColor, kStopGradientColor],
  ),
);

const kErrorTextColor = Color(0xFFFF8845);

const kInputAreaCaptionTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
);

final kInputAreaCaptionErrorTextStyle = kInputAreaCaptionTextStyle.copyWith(color: kErrorTextColor);

const kDoneButtonWidth = 187.0;
const kDoneButtonHeight = 48.0;

const kDoneButtonProgressIndicatorHeight = kDoneButtonHeight * 0.55;

const kDoneButtonBorderRadius = BorderRadius.all(Radius.circular(12));
const kDoneButtonDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: kDoneButtonBorderRadius,
);

final kDoneButtonDecorationDisabled =
    kDoneButtonDecoration.copyWith(color: Colors.white.withOpacity(0.2));

const kDoneButtonTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 17.2,
  fontWeight: FontWeight.w500,
  letterSpacing: -0.2,
);

final kDoneButtonTextStyleDisabled = kDoneButtonTextStyle.copyWith(
  color: Colors.white.withOpacity(0.5),
);

const kBarrierColor = Colors.black26;

//---
// Экран "Как тебя зовут?"

const kTextInputTextStyle =
    TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
final kHintTextStyle =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: Colors.white.withOpacity(0.7));

const kInputLeftPadding = 18.0;

final kTextInputDecoration = InputDecoration(
  counterText: '',
  hintText: '',
  hintStyle: kHintTextStyle,
  fillColor: Colors.white.withOpacity(0.25),
  filled: true,
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: kInputLeftPadding),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white.withOpacity(0.1), width: 3),
    borderRadius: BorderRadius.circular(13),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white.withOpacity(0.1), width: 3),
    borderRadius: BorderRadius.circular(13),
  ),
);

final kTextInputDecorationError = kTextInputDecoration.copyWith(
  hintStyle: kTextInputDecoration.hintStyle!.copyWith(color: kErrorTextColor),
  enabledBorder: kTextInputDecoration.enabledBorder!.copyWith(
    borderSide: const BorderSide(color: kErrorTextColor, width: 3),
  ),
  focusedBorder: kTextInputDecoration.focusedBorder!.copyWith(
    borderSide: const BorderSide(color: kErrorTextColor, width: 3),
  ),
);

final kDateTimeDecoration = BoxDecoration(
  color: Colors.white.withOpacity(0.25),
  borderRadius: const BorderRadius.all(Radius.circular(13)),
  border: Border.all(color: Colors.white.withOpacity(0.1), width: 3),
);

final kDateTimeDecorationErrorBorder = Border.all(color: kErrorTextColor, width: 3);
