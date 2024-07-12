import 'package:json_annotation/json_annotation.dart';
import 'package:orders_app/domain/entities/product_order.dart';

part 'order.g.dart';

/// Estado del pedido.
///
///   - [cancelled] Pedido cancelado
///   - [completed] Pedido pagado y enviado
///   - [pending] Pedido pendiente en confirmar
enum OrderStatus { cancelled, completed, pending, noShow }

/// Tipo de pedido.
///
///  - [promo] el pedido sale gratis.
///  - [direct] toca pagar el pedido.
enum OrderType { promo, direct }

/// Tipos de métodos de pago.
enum PaymentMethod { visa, mastercard }

/// Entidad para pedidos.

@JsonSerializable()
class Order {
  final int id;

  /// Fecha de creación.
  final DateTime createdAt;

  /// Fecha de actualización.
  final DateTime updatedAt;

  /// Nombre de la orden.
  final String companyName;

  /// Dirección de envío de pedido.
  final String address;

  /// Listado de ids de los productos relacionados al pedido.
  final List<ProductOrder> products;

  /// Tipo de pedido.
  final OrderType type;

  /// Estado del pedido.
  final OrderStatus status;

  /// Propina
  final double tip;

  /// Costo de envio.
  final double shipment;

  /// Metodo de pago.
  final PaymentMethod? paymentMethod;

  /// Id de usuario relacionado.
  final String uuid;

  /// Imagen del pedido.
  final String imageId;

  const Order({
    required this.id,
    required this.createdAt,
    required this.companyName,
    required this.address,
    this.products = const [],
    this.type = OrderType.direct,
    this.status = OrderStatus.pending,
    this.tip = 0,
    this.shipment = 0,
    this.paymentMethod,
    required this.uuid,
    this.imageId = "",
  }) : updatedAt = createdAt;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  /// Precio de todos los productos del pedido con descuento [priceWithDiscount]
  double get priceWithDiscount {
    double price = 0;
    for (var product in products) {
      final priceDiscount = product.price * product.count * product.discount;
      final priceTotal = product.price * product.count;
      price += (priceTotal - priceDiscount);
    }

    return price;
  }

  /// El precio total del pedido.
  ///
  /// Incluye:
  ///  - El precio de todos los productos con descuento [priceWithDiscount]
  ///  - El precio del evnío [shipment]
  ///  - La propina [tip]
  double get totalPrice => priceWithDiscount + shipment + tip;

  /// El pedido es de tipo PromoLive [OrderType.promo]
  bool get isPromo => type == OrderType.promo;

  Order copyWith({
    final int? id,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final String? companyName,
    final String? address,
    final List<ProductOrder>? products,
    final OrderType? type,
    final OrderStatus? status,
    final double? tip,
    final double? shipment,
    final PaymentMethod? paymentMethod,
    final String? uuid,
    final String? imageId,
  }) {
    return Order(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      companyName: companyName ?? this.companyName,
      address: address ?? this.address,
      products: products ?? this.products,
      type: type ?? this.type,
      status: status ?? this.status,
      tip: tip ?? this.tip,
      shipment: shipment ?? this.shipment,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      uuid: uuid ?? this.uuid,
      imageId: imageId ?? this.imageId,
    );
  }

  @override
  String toString() {
    return "Order{"
        "\n  id: $id,"
        "\n  createdAt: $createdAt,"
        "\n  updatedAt: $updatedAt,"
        "\n  companyName: $companyName,"
        "\n  address: $address,"
        "\n  products: $products,"
        "\n  type: $type,"
        "\n  status: $status,"
        "\n  tip: $tip,"
        "\n  shipment: $shipment,"
        "\n  paymentMethod: $paymentMethod,"
        "\n  uuid: $uuid,"
        "\n  imageId: $imageId"
        "\n}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          companyName == other.companyName &&
          address == other.address &&
          products == other.products &&
          type == other.type &&
          status == other.status &&
          tip == other.tip &&
          shipment == other.shipment &&
          paymentMethod == other.paymentMethod &&
          uuid == other.uuid &&
          imageId == other.imageId;

  @override
  int get hashCode =>
      id.hashCode ^
      updatedAt.hashCode ^
      companyName.hashCode ^
      address.hashCode ^
      products.hashCode ^
      type.hashCode ^
      status.hashCode ^
      tip.hashCode ^
      shipment.hashCode ^
      paymentMethod.hashCode ^
      uuid.hashCode ^
      imageId.hashCode;
}
