import 'package:orders_app/data/datasources/orders_datasource.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  final OrdersDatasource datasource;

  OrdersRepositoryImpl(this.datasource);

  @override
  Future<Order?> get(int id) async {
    try {
      final result = await datasource.get(id);
      return Future.value(result);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Order>> getAll() async {
    try {
      final result = await datasource.getAll();
      return Future.value(result);
    } catch (e) {
      return Future.error(e);
    }
  }
}
