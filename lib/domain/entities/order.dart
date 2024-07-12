import 'package:json_annotation/json_annotation.dart';
import 'package:orders_app/domain/entities/product_order.dart';

part 'order.g.dart';

/// Estado del pedido.
///
///   - [cancelled] Pedido cancelado
///   - [completed] Pedido pagado y enviado
///   - [pending] Pedido pendiente en confirmar
enum OrderStatus { cancelled, completed, pending, noShow }

/// Tipos de Metodos de pago
enum PaymentMethod { visa, mastercard }

/// Entidad para Pedidos.

@JsonSerializable()
class Order {
  final int id;

  /// Fecha de creacion.
  final DateTime createdAt;

  /// Fecha de actualizacion.
  final DateTime updatedAt;

  /// Nombre de la orden.
  final String companyName;

  /// Direccion de envio de pedido.
  final String address;

  /// Listado de ids de los productos relacionados al pedido.
  final List<ProductOrder> products;

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
    this.status = OrderStatus.pending,
    this.tip = 0,
    this.shipment = 0,
    this.paymentMethod,
    required this.uuid,
    this.imageId = "",
  }) : updatedAt = createdAt;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  double get priceWithDiscount {
    double price = 0;
    for (var product in products) {
      price += product.price * product.discount;
    }

    return price;
  }

  double get totalPrice => priceWithDiscount + shipment + tip;

  bool get isPromoLive => shipment == 0;

  @override
  String toString() {
    return "Order{"
        "\n  id: $id,"
        "\n  createdAt: $createdAt,"
        "\n  updatedAt: $updatedAt,"
        "\n  companyName: $companyName,"
        "\n  address: $address,"
        "\n  products: $products,"
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
      status.hashCode ^
      tip.hashCode ^
      shipment.hashCode ^
      paymentMethod.hashCode ^
      uuid.hashCode ^
      imageId.hashCode;
}
