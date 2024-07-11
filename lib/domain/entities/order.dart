import 'package:json_annotation/json_annotation.dart';
import 'package:orders_app/domain/entities/product_order.dart';

part 'order.g.dart';

/// Estado del pedido.
///
///   - [cancelled] Pedido cancelado
///   - [completed] Pedido pagado y enviado
///   - [pending] Pedido pendiente en confirmar
enum OrderStatus { cancelled, completed, pending }

enum PaymentMethod { visa, mastercard }

/// Entidad para Pedidos.

@JsonSerializable()
class Order {
  final int id;

  /// Fecha de creacion.
  final DateTime createdAt;

  /// Nombre de la orden.
  final String name;

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
    required this.name,
    this.products = const [],
    this.status = OrderStatus.pending,
    this.tip = 0,
    this.shipment = 0,
    this.paymentMethod,
    required this.uuid,
    this.imageId = "",
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  String toString() {
    return "Order{"
        "\n  id: $id,"
        "\n  createdAt: $createdAt,"
        "\n  name: $name,"
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
          name == other.name &&
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
      createdAt.hashCode ^
      name.hashCode ^
      products.hashCode ^
      status.hashCode ^
      tip.hashCode ^
      shipment.hashCode ^
      paymentMethod.hashCode ^
      uuid.hashCode ^
      imageId.hashCode;
}
