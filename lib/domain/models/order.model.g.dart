// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map<String, dynamic> json) => Receipt(
      id: json['id'] as int?,
      date: json['date'] as int?,
      attributes: ReceiptAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
      observation: json['observation'] as String?,
      user_id: json['user_id'] as int,
      category_id: json['category_id'] as int?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'category_id': instance.category_id,
      'date': instance.date,
      'observation': instance.observation,
      'attributes': instance.attributes,
      'totalPrice': instance.totalPrice,
    };

ReceiptAttributes _$ReceiptAttributesFromJson(Map<String, dynamic> json) =>
    ReceiptAttributes(
      stories: (json['stories'] as List<dynamic>)
          .map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReceiptAttributesToJson(ReceiptAttributes instance) =>
    <String, dynamic>{
      'stories': instance.stories,
    };
