import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ColorPair with EquatableMixin {
  final int id;
  final Color startGradiendColor;
  final Color stopGradiendColor;

  const ColorPair({
    required this.id,
    required this.startGradiendColor,
    required this.stopGradiendColor,
  });

  @override
  List<Object?> get props => [id, startGradiendColor, stopGradiendColor];
}
