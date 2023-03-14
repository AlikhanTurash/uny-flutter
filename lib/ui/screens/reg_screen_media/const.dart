import 'package:flutter/material.dart';

const kBackgroundColor = Colors.white;

const kHorizPadding = 18.0;

const kTopPadding = 70.0;
const kTopPaddingSmall = 52.0;

const kBigTextStyle = TextStyle(
  fontSize: 22.5,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const kBigTextBottomMargin = 8.0;

final kSubTextStyle = TextStyle(
  fontSize: 17.5,
  color: Colors.black.withOpacity(0.5),
);

const kNextButtonWidth = 187.0;
const kNextButtonHeight = 48.0;

const kNextButtonProgressIndicatorHeight = kNextButtonHeight * 0.55;

const kNextButtonBorderRadius = BorderRadius.all(Radius.circular(12));
const kNextButtonDecoration = BoxDecoration(
  color: Color(0xFF910AFB),
  borderRadius: kNextButtonBorderRadius,
  boxShadow: [BoxShadow(color: Colors.white, blurRadius: 12, spreadRadius: 15)],
);

final kNextButtonDecorationDisabled =
    kNextButtonDecoration.copyWith(color: const Color(0xFFD3D3D3));

const kNextButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 17.2,
  fontWeight: FontWeight.w500,
  letterSpacing: -0.2,
);

final kNextButtonTextStyleDisabled = kNextButtonTextStyle.copyWith(
  color: const Color(0xFF7C7C7C),
);

final kGridPhotoDecoration = BoxDecoration(
  color: const Color(0xFFF0F0F0),
  borderRadius: const BorderRadius.all(Radius.circular(12)),
  border: Border.all(
    width: 1.5,
    color: const Color(0xFFEBEBEB),
  ),
);

final kGridFirstPhotoDecoration = BoxDecoration(
  color: const Color(0xFFFFE5B9),
  borderRadius: const BorderRadius.all(Radius.circular(12)),
  border: Border.all(
    width: 1.5,
    color: const Color(0xFFFF9D0A),
  ),
);

final kGridPhotoImageBorder = Border.all(
  width: 1.5,
  color: Colors.grey.withOpacity(0.45),
);

const kBarrierColor = Colors.black26;
