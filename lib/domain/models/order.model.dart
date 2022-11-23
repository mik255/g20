
import 'package:g20/domain/models/results.model.dart';
import 'package:g20/domain/models/story.model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'category.model.dart';
import 'paymentType.model.dart';

part 'order.model.g.dart';

@JsonSerializable()
class Receipt {
  int? id;
  int user_id;
  int? category_id;
  int? date;
  String? observation;
  ReceiptAttributes attributes;
  double? totalPrice;
  Receipt({
    this.id,
    required this.date,
    required this.attributes,
    required this.observation,
    required this.user_id,
    required this.category_id,
    this.totalPrice = 0,
  });
  factory Receipt.fromJson(Map<String, dynamic> json) => _$ReceiptFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
  double getTotal(){
    double total = 0;
   for (var element in attributes.stories) {
    total+=element.getTotal();
  }
   return totalPrice = total;
  }
}

@JsonSerializable()
class ReceiptAttributes{
  ReceiptAttributes({required this.stories});
  List<Story> stories;
  factory ReceiptAttributes.fromJson(Map<String, dynamic> json) => _$ReceiptAttributesFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReceiptAttributesToJson(this);
}
