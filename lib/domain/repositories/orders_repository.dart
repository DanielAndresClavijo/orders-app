import 'package:orders_app/domain/entities/order.dart';

abstract class OrdersRepository {
  Future<Order?> get(int id);

  Future<List<Order>> getAll();
}
