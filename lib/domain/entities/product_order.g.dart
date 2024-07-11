// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOrder _$ProductOrderFromJson(Map<String, dynamic> json) => ProductOrder(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      orderId: (json['orderId'] as num).toInt(),
    );

Map<String, dynamic> _$ProductOrderToJson(ProductOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'price': instance.price,
      'discount': instance.discount,
      'orderId': instance.orderId,
    };
