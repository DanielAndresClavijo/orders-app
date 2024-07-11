// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductOrder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status']) ??
          OrderStatus.pending,
      tip: (json['tip'] as num?)?.toDouble() ?? 0,
      shipment: (json['shipment'] as num?)?.toDouble() ?? 0,
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['paymentMethod']),
      uuid: json['uuid'] as String,
      imageId: json['imageId'] as String? ?? "",
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'products': instance.products,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'tip': instance.tip,
      'shipment': instance.shipment,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod],
      'uuid': instance.uuid,
      'imageId': instance.imageId,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.cancelled: 'cancelled',
  OrderStatus.completed: 'completed',
  OrderStatus.pending: 'pending',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.visa: 'visa',
  PaymentMethod.mastercard: 'mastercard',
};
