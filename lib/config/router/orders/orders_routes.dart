import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/navigation_history.dart';
import 'package:orders_app/config/router/common_router.dart';
import 'package:orders_app/ui/core/components/base/authorized_user_base_page.dart';
import 'package:orders_app/ui/features/orders/order_detail_page.dart';
import 'package:orders_app/ui/features/orders/order_list_page.dart';

part 'orders_routes_texts.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell2');

/// Rutas para las paginas de pedidos.
class OrdersRoutes {
  /// # Contiene las rutas para los pedidos.
  ///
  /// Las rutas registradas para los pedidos son:
  ///  - Listado de pedidos
  ///  - Detalle de pedido
  ///  - Historial de pedidos
  final ShellRoute routes;

  const OrdersRoutes._(this.routes);

  factory OrdersRoutes(NavigationHistory navigationHistory) {
    final baseRoute = _buildBaseRoute();
    final ShellRoute main = ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, GoRouterState state, Widget child) {
        return getDefaultTransitionPage(
          key: state.pageKey,
          child: AuthorizedBasePage(
            navigationHistory: navigationHistory,
            child: child,
          ),
        );
      },
      routes: [
        baseRoute,
      ],
    );
    return OrdersRoutes._(main);
  }

  /// Construye la ruta base para los pedidos
  static GoRoute _buildBaseRoute() {
    final GoRoute ordersListRoute = _buildOrdersListRoute();
    final GoRoute orderDetailRoute = _buildOrderDetailRoute();
    return GoRoute(
      path: kOrderBasePath,
      builder: (context, state) => const Center(),
      routes: [
        ordersListRoute,
        orderDetailRoute,
      ],
    );
  }

  /// Construye la ruta para el listado de pedidos
  static GoRoute _buildOrdersListRoute() {
    return GoRoute(
      path: _kOrderListSubPath,
      name: kOrdersListPathName,
      pageBuilder: (context, state) => getDefaultTransitionPage(
        key: state.pageKey,
        child: const OrderListPage(),
      ),
    );
  }

  /// Construye la ruta para mostrar el detalle del pedido.
  static GoRoute _buildOrderDetailRoute() {
    return GoRoute(
      path: "$_kOrderDetailSubPath/:orderId",
      name: kOrderDetailPathName,
      redirect: (context, state) {
        if (state.pathParameters['orderId'] == null) return kOrdersListPath;
        return null;
      },
      pageBuilder: (context, state) => getDefaultTransitionPage(
        key: state.pageKey,
        child: OrderDetailPage(
          orderId: int.tryParse(state.pathParameters['orderId']!) ?? -1,
        ),
      ),
    );
  }
}