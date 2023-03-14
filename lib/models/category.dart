import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:unyapp/models/color_pair.dart';

class Category with EquatableMixin {
  final int id;
  final String name;
  final Color mainColor;
  final List<ColorPair> colors;

  const Category({
    required this.id,
    required this.name,
    required this.mainColor,
    required this.colors,
  });

  @override
  List<Object?> get props => [id, name, mainColor, colors];
}
