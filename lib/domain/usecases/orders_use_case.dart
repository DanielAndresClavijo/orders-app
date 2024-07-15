import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/domain/repositories/orders_repository.dart';

abstract class OrdersUseCase {
  /// Obtiene los detalles de un pediddo por [id]
  Future<Order?> get(int id);

  /// Obtiene todos los pedidos.
  ///
  ///  - [status]: Para filtrar por el estado de la orden.
  ///  - [limit]: Para la paginación, específica el número de resultados por página.
  ///  - [offset]: Para la paginación, específica desde qué posición empezar.
  ///              a devolver los resultados.
  ///
  /// output:
  ///  [totalOrders]: Número total de pedidos para el usuario logueado.
  ///  [orders]: Todos los Pedidos según el filtro.
  Future<(int totalOrders, List<Order> orders)> getAll({
    final OrderStatus? status,
    final int? limit,
    final int? offset,
  });
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
  Future<(int totalOrders, List<Order> orders)> getAll({
    final OrderStatus? status,
    final int? limit,
    final int? offset,
  }) async {
    try {
      final result = await repository.getAll(
        status: status,
        limit: limit,
        offset: offset,
      );
      return Future.value(result);
    } catch (e) {
      return Future.error(e);
    }
  }
}
