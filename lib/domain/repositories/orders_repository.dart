import 'package:orders_app/domain/entities/order.dart';

abstract class OrdersRepository {
  /// Obtiene los detalles de un pedido por [id]
  ///
  ///  - [id]: Para filtrar por ID de pedido.
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
