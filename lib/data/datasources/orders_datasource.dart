import 'package:orders_app/domain/entities/order.dart';

/// Fuente de datos para los pedidos.
///
/// Contacte directamente con el cliente del servidor mediante esta entidad.
///
///  Nota: Utilizarla solo desde los repositorios.
abstract class OrdersDatasource {
  /// Obtiene los detalles de un pediddo por [id]
  Future<Order?> get(int id);

  /// Obtiene todos los pedidos.
  Future<List<Order>> getAll();
}
