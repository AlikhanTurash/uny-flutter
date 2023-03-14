import 'package:flutter/material.dart';
import 'package:unyapp/models/category.dart';
import 'package:unyapp/models/color_pair.dart';

const List<Category> unyCategories = [
  Category(
    id: 1,
    name: 'Семья',
    mainColor: Color(0xFF29A32E),
    colors: [
      ColorPair(id: 1, startGradiendColor: Color(0xFF4DE33F), stopGradiendColor: Color(0xFF53EA7A)),
      ColorPair(id: 2, startGradiendColor: Color(0xFF079F3B), stopGradiendColor: Color(0xFF09561F)),
      ColorPair(id: 3, startGradiendColor: Color(0xFFBEE22A), stopGradiendColor: Color(0xFF9EDA29)),
    ],
  ),
  Category(
    id: 2,
    name: 'Карьера',
    mainColor: Color(0xFF01BCF8),
    colors: [
      ColorPair(id: 4, startGradiendColor: Color(0xFF04DFDF), stopGradiendColor: Color(0xFF20D8D8)),
      ColorPair(id: 5, startGradiendColor: Color(0xFF51D6AE), stopGradiendColor: Color(0xFF53D6CE)),
      ColorPair(id: 6, startGradiendColor: Color(0xFF3DC6E9), stopGradiendColor: Color(0xFF16C9F7)),
    ],
  ),
  Category(
    id: 3,
    name: 'Спорт',
    mainColor: Color(0xFF297BFD),
    colors: [
      ColorPair(id: 7, startGradiendColor: Color(0xFF0C41FD), stopGradiendColor: Color(0xFF236FF0)),
      ColorPair(id: 8, startGradiendColor: Color(0xFF1678DA), stopGradiendColor: Color(0xFF165DD8)),
      ColorPair(id: 9, startGradiendColor: Color(0xFF73AFFF), stopGradiendColor: Color(0xFF518FF1)),
    ],
  ),
  Category(
    id: 4,
    name: 'Путешествия',
    mainColor: Color(0xFFFFB526),
    colors: [
      ColorPair(
          id: 10, startGradiendColor: Color(0xFFFEDE02), stopGradiendColor: Color(0xFFE79801)),
      ColorPair(
          id: 11, startGradiendColor: Color(0xFFFF8602), stopGradiendColor: Color(0xFFFF9701)),
      ColorPair(
          id: 12, startGradiendColor: Color(0xFFFFC168), stopGradiendColor: Color(0xFFFF9900)),
    ],
  ),
  Category(
    id: 5,
    name: 'Общее',
    mainColor: Color(0xFF910AFB),
    colors: [
      ColorPair(
          id: 13, startGradiendColor: Color(0xFFD002FF), stopGradiendColor: Color(0xFFA702FF)),
      ColorPair(
          id: 14, startGradiendColor: Color(0xFF4D02A9), stopGradiendColor: Color(0xFF7A0EC2)),
      ColorPair(
          id: 15, startGradiendColor: Color(0xFF556EF1), stopGradiendColor: Color(0xFF9C74FA)),
    ],
  ),
];
