// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      companyName: json['company_name'] as String,
      address: json['address'] as String,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductOrder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      type: $enumDecodeNullable(_$OrderTypeEnumMap, json['type']) ??
          OrderType.direct,
      status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status']) ??
          OrderStatus.pending,
      tip: (json['tip'] as num?)?.toDouble() ?? 0,
      shipment: (json['shipment'] as num?)?.toDouble() ?? 0,
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['payment_method']),
      uuid: json['user_id'] as String,
      imageId: json['image_id'] as String? ?? "",
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'company_name': instance.companyName,
      'address': instance.address,
      'products': instance.products,
      'type': _$OrderTypeEnumMap[instance.type]!,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'tip': instance.tip,
      'shipment': instance.shipment,
      'payment_method': _$PaymentMethodEnumMap[instance.paymentMethod],
      'user_id': instance.uuid,
      'image_id': instance.imageId,
    };

const _$OrderTypeEnumMap = {
  OrderType.promo: 'promo',
  OrderType.direct: 'direct',
};

const _$OrderStatusEnumMap = {
  OrderStatus.cancelled: 'cancelled',
  OrderStatus.completed: 'completed',
  OrderStatus.pending: 'pending',
  OrderStatus.noShow: 'noShow',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.visa: 'visa',
  PaymentMethod.mastercard: 'mastercard',
};
