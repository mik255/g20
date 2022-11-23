// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      id: json['id'] as int,
      name: json['name'] as String,
      productList: (json['productList'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
      pix: json['pix'] as String,
      paymentType: json['paymentType'] as String?,
    )..productsBag = (json['productsBag'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toSet();

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'productList': instance.productList,
      'productsBag': instance.productsBag?.toList(),
      'pix': instance.pix,
      'paymentType': instance.paymentType,
      'totalPrice': instance.totalPrice,
    };
