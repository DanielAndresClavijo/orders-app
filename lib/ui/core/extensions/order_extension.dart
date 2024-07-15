import 'package:flutter/material.dart';
import 'package:orders_app/config/assets.dart';
import 'package:orders_app/domain/entities/order.dart';

extension OrderExtension on Order {
  /// Texto para el estado de pedido.
  String get typeOrderText => status.text;

  /// Obtiene el texto para el asset SVG del ícono del promo del pedido.
  String get assetOrderTypeIconText {
    if (isPromo) return Assets.promoLiveIcon;
    return Assets.lineRoundedConnectIcon;
  }

  /// Obtiene el texto para el tipo de oferta del pedido.
  String get shipmentTypeText {
    if (isPromo) return "Promo Live";
    return "Direct";
  }

  /// Color para el estado de pedido.
  Color? get typeOrderColor {
    switch (status) {
      case OrderStatus.noShow:
      case OrderStatus.cancelled:
        return Colors.red;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.pending:
      default:
        return null;
    }
  }
}
