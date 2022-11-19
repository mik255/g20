import 'package:g20/domain/models/paymentType.model.dart';

import 'product.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story.model.g.dart';

@JsonSerializable()
class Story {
  int id;
  String name;
  List<Product> productList;
  Set<Product>? productsBag;
  String pix;
  String? paymentType;
  @JsonKey(defaultValue: 0, disallowNullValue: false)
  double totalPrice;

  Story({
    required this.id,
    required this.name,
    required this.productList,
    required this.totalPrice,
    required this.pix,
    this.paymentType
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StoryToJson(this);

  double getTotal(){
    double total =0;
     for (var e in productList) {
      total+=(e.price*e.count);
    }
    return total;
  }

}
