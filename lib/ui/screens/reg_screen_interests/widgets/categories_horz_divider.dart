import 'package:flutter/material.dart';

class CategoriesHorzDivider extends StatelessWidget {
  const CategoriesHorzDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 1),
      child: Container(width: 38, height: 2, color: Colors.black.withOpacity(0.15)),
    );
  }
}
