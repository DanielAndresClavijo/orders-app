import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/screens/orders/order_detail.dart';
import 'package:orders_app/screens/orders/order_history.dart';
import 'package:orders_app/screens/orders/order_list.dart';

/// Path inicial para las rutas de pedidos.
const String _kOrderBasePath = "/orders";

/// Sub-path para la ruta de listado de pedidos.
///
/// Nota: El sub-path es utilizado por GoRoute para las rutas anidadas.
const String _kOrderListSubPath = "list";

/// # Ruta para navegar al listado de pedidos.
///
///  __Ruta `/orders/list`__
const String kOrdersListPath = "$_kOrderBasePath/$_kOrderListSubPath";

/// # Nombre de Ruta para navegar al listado de pedidos.
///
///  Nota: El nombre de ruta se usa como identificador unico de la ruta, que
///  en algunas ocasiones puede ser util para cuando se navega por nombre.
///
///  __Nombre de Ruta `ordersPathName`__
const String kOrdersListPathName = "ordersPathName";

/// Sub-path para la ruta del detalle de pedido.
///
/// Nota: El sub-path es utilizado por GoRoute para las rutas anidadas.
const String _kOrderDetailSubPath = "detail";

/// # Ruta para navegar al detalle del pedido.
///
///  Nota: Es necesario agregar el id del pedido al final de la ruta precedido
///  de `/`. Ej: `orders/detail/123`
///
///  __Ruta `/orders/detail`__
const String kOrderDetailPath = "$_kOrderBasePath/$_kOrderDetailSubPath";

/// # Nombre de Ruta para navegar al detalle de algun pedido.
///
///  Nota: El nombre de ruta se usa como identificador unico de la ruta, que
///  en algunas ocasiones puede ser util para cuando se navega por nombre.
///
///  __Nombre de Ruta `orderDetailPathName`__
const String kOrderDetailPathName = "orderDetailPathName";

/// Sub-path para la ruta del historial de pedidos.
///
/// Nota: El sub-path es utilizado por GoRoute para las rutas anidadas.
const String _kOrdersHistorySubPath = "history";

/// # Ruta para navegar al historial de pedidos.
///
/// __Ruta `/orders/history`__
const String kOrdersHistoryPath = "$_kOrderBasePath/$_kOrdersHistorySubPath";

/// # Nombre de Ruta para navegar al historial pedidos.
///
///  Nota: El nombre de ruta se usa como identificador unico de la ruta, que
///  en algunas ocasiones puede ser util para cuando se navega por nombre.
///
///  __Nombre de Ruta `historyPathName`__
const String kOrdersHistoryPathName = "historyPathName";

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
