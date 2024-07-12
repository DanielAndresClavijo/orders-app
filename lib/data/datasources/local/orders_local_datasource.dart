import 'package:orders_app/data/datasources/orders_datasource.dart';
import 'package:orders_app/domain/entities/order.dart';

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
  ),
  Order(
    id: 2,
    createdAt: DateTime(2024, 6, 10, 16, 55),
    companyName: "Habibi",
    address: "Benito Juárez #231",
    uuid: "1",
  ),
  Order(
    id: 3,
    createdAt: DateTime(2024, 6, 10, 16, 55),
    companyName: "Habibi",
    address: "Benito Juárez #231",
    uuid: "1",
  ),
];
