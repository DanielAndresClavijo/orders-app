import 'package:orders_app/domain/entities/order.dart';

/// Fuente de datos para los pedidos.
///
/// Contacte directamente con el cliente del servidor mediante esta entidad.
///
///  Nota: Utilizarla solo desde los repositorios.
abstract class OrdersDatasource {
  /// Obtiene los detalles de un pediddo por [id]
  ///
  ///  - [id]: Para filtrar por ID de pedido.
  Future<Order?> get(int id);

  /// Obtiene todos los pedidos.
  ///
  ///  - [status]: Para filtrar por el estado de la orden.
  ///  - [limit]: Para la paginación, especifica el número de resultados por página.
  ///  - [offset]: Para la paginación, especifica desde qué posición empezar
  ///              a devolver los resultados.
  Future<(int totalOrders, List<Order> orders)> getAll({
    final OrderStatus? status,
    final int? limit,
    final int? offset,
  });
}
