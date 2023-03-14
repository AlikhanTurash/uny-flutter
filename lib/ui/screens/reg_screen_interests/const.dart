import 'package:flutter/material.dart';

const kBackgroundColor = Colors.white;

const kHorizPadding = 18.0;

const kTopPadding = 39.0;

const kGreyColor = Color(0xFFA6A7AC);

const kCategoryTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: kGreyColor,
);

const kActiveCategoryTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: Colors.black,
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

const kSelectCategoryLabelStyle = TextStyle(
  fontSize: 17.3,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

final kCategoryNameTextStyle = TextStyle(
  color: Colors.grey.shade800.withOpacity(0.8),
  fontSize: 17,
  fontWeight: FontWeight.w500,
);

final kSelectedCategoryNameTextStyle = kCategoryNameTextStyle.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Colors.white,
);
