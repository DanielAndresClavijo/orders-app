import 'package:json_annotation/json_annotation.dart';

part 'product_order.g.dart';

/// Entidad que representa un producto de alguna orden creada.
@JsonSerializable()
class ProductOrder {
  /// id de la entidad.
  final int id;

  /// Fecha de creacion.
  final DateTime createdAt;

  /// Nombre del producto.
  final String name;

  /// Precio bruto del producto sin aplicar descuento.
  final double price;

  /// Descuento.
  ///
  /// Manejar rangos entre 0 y 1.
  final double discount;

  /// Cantidad de productos en el pedido.
  final int count;

  /// Id que relaciona este producto con un pedido.
  final int orderId;

  const ProductOrder({
    required this.id,
    required this.createdAt,
    required this.name,
    this.price = 0,
    this.discount = 0,
    this.count = 1,
    required this.orderId,
  });

  factory ProductOrder.fromJson(Map<String, dynamic> json) =>
      _$ProductOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOrderToJson(this);

  /// Descuento de precio completo.
  double get totalPriceDiscount => price * count * discount;

  /// Precio total del producto.
  double get totalPrice => price * count;

  /// Precio total del producto con el descuento aplicado.
  double get totalPriceWithDiscount => totalPrice - totalPriceDiscount;

  ProductOrder copyWith({
    final int? id,
    final DateTime? createdAt,
    final String? name,
    final double? price = 0,
    final double? discount = 0,
    final int? count = 0,
    final int? orderId,
  }) {
    return ProductOrder(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      orderId: orderId ?? this.orderId,
      discount: discount ?? this.discount,
      count: count ?? this.count,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return "ProductOrder{"
        "\n  id: $id,"
        "\n  createdAt: $createdAt,"
        "\n  name: $name,"
        "\n  price: $price,"
        "\n  discount: $discount,"
        "\n  count: $count,"
        "\n  orderId: $orderId"
        "\n}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductOrder &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          createdAt == other.createdAt &&
          name == other.name &&
          price == other.price &&
          discount == other.discount &&
          count == other.count &&
          orderId == other.orderId;

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      name.hashCode ^
      price.hashCode ^
      discount.hashCode ^
      count.hashCode ^
      orderId.hashCode;
}
