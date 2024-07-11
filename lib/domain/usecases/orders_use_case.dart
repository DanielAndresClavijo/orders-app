import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/domain/repositories/orders_repository.dart';

abstract class OrdersUseCase {
  /// Obtiene los detalles de un pediddo por [id]
  Future<Order?> get(int id);

  /// Obtiene todos los pedidos.
  Future<List<Order>> getAll();
}

class OrdersUseCaseImpl extends OrdersUseCase {
  final OrdersRepository repository;

  OrdersUseCaseImpl(this.repository);

  @override
  Future<Order?> get(int id) async {
    try {
      final result = await repository.get(id);
      return Future.value(result);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Order>> getAll() async {
    try {
      final result = await repository.getAll();
      return Future.value(result);
    } catch (e) {
      return Future.error(e);
    }
  }
}
