import 'dart:ui';

import 'package:equatable/equatable.dart';

class Photo with EquatableMixin {
  final int id;
  final int position;
  final bool isMain;
  final Image image;

  const Photo(
      {required this.id,
      required this.position,
      required this.isMain,
      required this.image});

  @override
  List<Object?> get props => [id, position, isMain, image];

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json['id'],
        position: json['position'],
        isMain: json['main'],
        image: json['path_photo'],
      );
}
