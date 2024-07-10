import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/ui/features/orders/order_detail.dart';
import 'package:orders_app/ui/features/orders/order_history.dart';
import 'package:orders_app/ui/features/orders/order_list.dart';

part 'orders_routes_texts.dart';

/// Rutas para las paginas de pedidos.
class OrdersRoutes {
  /// # Contiene las rutas para los pedidos.
  ///
  /// Las rutas registradas para los pedidos son:
  ///  - Listado de pedidos
  ///  - Detalle de pedido
  ///  - Historial de pedidos
  final GoRoute routes;

  const OrdersRoutes._(this.routes);

  factory OrdersRoutes() {
    final GoRoute ordersListRoute = _buildOrdersListRoute();
    final GoRoute orderDetailRoute = _buildOrderDetailRoute();
    final GoRoute ordersHistoryRoute = _buildOrdersHistoryRoute();
    final GoRoute main = GoRoute(
      path: _kOrderBasePath,
      builder: (_, __) => const Center(),
      routes: [
        ordersListRoute,
        orderDetailRoute,
        ordersHistoryRoute,
      ],
    );
    return OrdersRoutes._(main);
  }

  /// Construye la ruta para el listado de pedidos
  static GoRoute _buildOrdersListRoute() {
    return GoRoute(
      path: _kOrderListSubPath,
      name: kOrdersListPathName,
      builder: (context, state) => const OrderList(),
    );
  }

  static GoRoute _buildOrderDetailRoute() {
    return GoRoute(
      path: "$_kOrderDetailSubPath/:orderId",
      name: kOrderDetailPathName,
      redirect: (context, state) {
        if (state.pathParameters['orderId'] == null) return kOrdersListPath;
        return null;
      },
      builder: (context, state) {
        return OrderDetail(
          orderId: state.pathParameters['orderId']!,
        );
      },
    );
  }

  static GoRoute _buildOrdersHistoryRoute() {
    return GoRoute(
      path: _kOrdersHistorySubPath,
      name: kOrdersHistoryPathName,
      builder: (context, state) => const OrderHistory(),
    );
  }
}
