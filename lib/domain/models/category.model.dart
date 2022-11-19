import 'package:g20/domain/models/story.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.model.g.dart';

@JsonSerializable()
class Category {
  int id;
  String name;
  bool isBlocked;
  List<Story> stories;

  Category({
    required this.id,
    required this.name,
    required this.isBlocked,
    required this.stories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
