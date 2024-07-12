import 'package:orders_app/data/datasources/orders_datasource.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/domain/entities/product_order.dart';

class OrdersLocalDatasource extends OrdersDatasource {
  @override
  Future<Order?> get(int id) async {
    final foundedOrder = _ordersMock.where((o) => o.id == id).firstOrNull;
    return Future.value(foundedOrder);
  }

  @override
  Future<List<Order>> getAll() async {
    return Future.value(_ordersMock);
  }
}

List<Order> _ordersMock = [
  Order(
    id: 1,
    createdAt: DateTime(2024, 6, 10, 16, 55),
    companyName: "Habibi",
    address: "Benito Juárez #231",
    uuid: "1",
    shipment: 60,
    tip: 13,
    status: OrderStatus.completed,
    type: OrderType.direct,
    paymentMethod: PaymentMethod.visa,
    products: [
      ProductOrder(
        id: 1,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Pizza italiana",
        price: 160,
        discount: 0.25,
        count: 2,
        orderId: 1,
      ),
      ProductOrder(
        id: 2,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Rebanada de pastel de chocolate",
        price: 136.6666666666667,
        discount: 0.1707317073170732,
        count: 3,
        orderId: 1,
      ),
      ProductOrder(
        id: 3,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Refresco de 1 lt",
        price: 62,
        discount: 0.3548387096774194,
        count: 1,
        orderId: 1,
      ),
    ],
  ),
  Order(
    id: 2,
    createdAt: DateTime(2024, 6, 10, 16, 55),
    companyName: "Boston's Pizza",
    address: "Benito Juárez #231",
    tip: 10,
    shipment: 16,
    status: OrderStatus.noShow,
    type: OrderType.promo,
    paymentMethod: PaymentMethod.visa,
    products: [
      ProductOrder(
        id: 1,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Pizza italiana",
        price: 160,
        discount: 0.25,
        count: 1,
        orderId: 2,
      ),
      ProductOrder(
        id: 2,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Refresco de 1 lt",
        price: 62,
        discount: 0.3548387096774194,
        count: 1,
        orderId: 2,
      ),
      ProductOrder(
        id: 3,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Refresco de 1 lt",
        price: 200,
        discount: 0.30,
        count: 2,
        orderId: 2,
      ),
    ],
    uuid: "1",
  ),
  Order(
    id: 3,
    createdAt: DateTime(2024, 6, 10, 16, 55),
    companyName: "Tabom",
    address: "Benito Juárez #231",
    shipment: 5,
    tip: 0,
    type: OrderType.promo,
    status: OrderStatus.completed,
    paymentMethod: PaymentMethod.visa,
    products: [
      ProductOrder(
        id: 1,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Rebanada de pastel de chocolate",
        price: 136.6666666666667,
        discount: 0.1707317073170732,
        count: 2,
        orderId: 3,
      ),
      ProductOrder(
        id: 2,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Refresco de 1 lt",
        price: 62,
        discount: 0.3548387096774194,
        count: 2,
        orderId: 3,
      ),
    ],
    uuid: "1",
  ),
  Order(
    id: 4,
    createdAt: DateTime(2024, 6, 10, 16, 55),
    companyName: "Roca",
    address: "Benito Juárez #231",
    shipment: 12,
    tip: 12,
    type: OrderType.direct,
    status: OrderStatus.completed,
    paymentMethod: PaymentMethod.mastercard,
    products: [
      ProductOrder(
        id: 1,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Pollo asado",
        price: 120,
        discount: 0.05,
        count: 2,
        orderId: 4,
      ),
      ProductOrder(
        id: 2,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Refresco de 500 ml",
        price: 30,
        discount: 0,
        count: 2,
        orderId: 4,
      ),
    ],
    uuid: "1",
  ),
  Order(
    id: 5,
    createdAt: DateTime(2024, 6, 10, 16, 55),
    companyName: "Habibi",
    address: "Benito Juárez #231",
    shipment: 25,
    tip: 10,
    type: OrderType.direct,
    status: OrderStatus.cancelled,
    paymentMethod: PaymentMethod.visa,
    products: [
      ProductOrder(
        id: 1,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Rebanada de pastel de chocolate",
        price: 136.6666666666667,
        discount: 0.1707317073170732,
        count: 5,
        orderId: 5,
      ),
    ],
    uuid: "1",
  ),
  Order(
    id: 6,
    createdAt: DateTime(2024, 6, 10, 16, 55),
    companyName: "Habibi",
    address: "Benito Juárez #231",
    shipment: 10,
    tip: 25,
    type: OrderType.direct,
    status: OrderStatus.completed,
    paymentMethod: PaymentMethod.mastercard,
    products: [
      ProductOrder(
        id: 1,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Rebanada de pastel de chocolate",
        price: 136.6666666666667,
        discount: 0.1707317073170732,
        count: 7,
        orderId: 6,
      ),
      ProductOrder(
        id: 2,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Refresco de 1 lt",
        price: 62,
        discount: 0.3548387096774194,
        count: 2,
        orderId: 6,
      ),
    ],
    uuid: "1",
  ),
  Order(
    id: 7,
    createdAt: DateTime(2024, 6, 10, 16, 55),
    companyName: "Habibi",
    address: "Benito Juárez #231",
    shipment: 16,
    tip: 5,
    type: OrderType.promo,
    status: OrderStatus.completed,
    paymentMethod: PaymentMethod.visa,
    products: [
      ProductOrder(
        id: 1,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Rebanada de pastel de chocolate",
        price: 136.6666666666667,
        discount: 0.1707317073170732,
        count: 4,
        orderId: 7,
      ),
      ProductOrder(
        id: 2,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Refresco de 1 lt",
        price: 62,
        discount: 0.3548387096774194,
        count: 2,
        orderId: 7,
      ),
    ],
    uuid: "1",
  ),
  Order(
    id: 8,
    createdAt: DateTime(2024, 6, 10, 16, 55),
    companyName: "Habibi",
    address: "Benito Juárez #231",
    shipment: 5,
    tip: 0,
    type: OrderType.promo,
    status: OrderStatus.completed,
    paymentMethod: PaymentMethod.visa,
    products: [
      ProductOrder(
        id: 3,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Refresco de 1 lt",
        price: 62,
        discount: 0.3548387096774194,
        count: 2,
        orderId: 8,
      ),
    ],
    uuid: "1",
  ),
  Order(
    id: 9,
    createdAt: DateTime(2024, 6, 11, 16, 55),
    companyName: "Boston's Pizza",
    address: "Benito Juárez #231",
    shipment: 14,
    tip: 5,
    type: OrderType.direct,
    status: OrderStatus.pending,
    paymentMethod: PaymentMethod.visa,
    products: [
      ProductOrder(
        id: 1,
        createdAt: DateTime(2024, 6, 11, 16, 55),
        name: "Rebanada de pastel de chocolate",
        price: 136.6666666666667,
        discount: 0.1707317073170732,
        count: 2,
        orderId: 9,
      ),
      ProductOrder(
        id: 2,
        createdAt: DateTime(2024, 6, 11, 16, 55),
        name: "Pollo asado",
        price: 62,
        discount: 0.3548387096774194,
        count: 2,
        orderId: 9,
      ),
    ],
    uuid: "1",
  ),
  Order(
    id: 10,
    createdAt: DateTime(2024, 6, 12, 16, 55),
    companyName: "Habibi",
    address: "Benito Juárez #231",
    shipment: 15,
    tip: 50,
    type: OrderType.direct,
    status: OrderStatus.cancelled,
    paymentMethod: PaymentMethod.visa,
    products: [
      ProductOrder(
        id: 2,
        createdAt: DateTime(2024, 6, 12, 16, 55),
        name: "Rebanada de pastel de chocolate",
        price: 136.6666666666667,
        discount: 0.1707317073170732,
        count: 3,
        orderId: 10,
      ),
      ProductOrder(
        id: 3,
        createdAt: DateTime(2024, 6, 12, 16, 55),
        name: "Refresco de 1 lt",
        price: 62,
        discount: 0.3548387096774194,
        count: 1,
        orderId: 10,
      ),
    ],
    uuid: "1",
  ),
  Order(
    id: 11,
    createdAt: DateTime(2024, 6, 13, 16, 55),
    companyName: "Habibi",
    address: "Benito Juárez #231",
    shipment: 30,
    tip: 1,
    type: OrderType.promo,
    status: OrderStatus.completed,
    paymentMethod: PaymentMethod.visa,
    products: [
      ProductOrder(
        id: 2,
        createdAt: DateTime(2024, 6, 13, 16, 55),
        name: "Rebanada de pastel de chocolate",
        price: 136.6666666666667,
        discount: 0.1707317073170732,
        count: 2,
        orderId: 11,
      ),
      ProductOrder(
        id: 3,
        createdAt: DateTime(2024, 6, 10, 16, 55),
        name: "Refresco de 1 lt",
        price: 62,
        discount: 0.3548387096774194,
        count: 2,
        orderId: 11,
      ),
    ],
    uuid: "1",
  ),
];
