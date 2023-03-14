import 'package:equatable/equatable.dart';

class Interest with EquatableMixin {
  final int id;
  final int categoryId;
  final String name;

  const Interest({
    required this.id,
    required this.categoryId,
    required this.name,
  });

  @override
  List<Object?> get props => [id, categoryId, name];

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
        id: json['id'],
        categoryId: json['interest_category_id'],
        name: json['name_translate'],
      );
}
