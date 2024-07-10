import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/router/auth/auth_routes.dart';
import 'package:orders_app/config/router/orders/orders_routes.dart';
import 'package:orders_app/config/router/welcome/welcome_routes.dart';
import 'package:orders_app/ui/core/unauthorized_user_base_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell1');

/// Enrutador para las paginas de la aplicacion.
class CommonRouter {
  final GoRouter router;

  const CommonRouter._(this.router);

  factory CommonRouter() {
    final AuthRoutes authRoutes = AuthRoutes();
    final WelcomeRoutes welcomeRoutes = WelcomeRoutes();
    final OrdersRoutes ordersRoutes = OrdersRoutes();

    final GoRouter router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: welcomeRoutes.splashRoute.path,
      debugLogDiagnostics: true,
      routes: [
        welcomeRoutes.splashRoute,
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder: (_, GoRouterState state, Widget child) {
            return getDefaultTransitionPage(
              key: state.pageKey,
              child: UnauthorizedBasePage(child: child),
            );
          },
          routes: [
            welcomeRoutes.homeRoute,
            authRoutes.loginRoute,
            authRoutes.registerRoute,
          ],
        ),
        ordersRoutes.routes,
      ],
    );
    return CommonRouter._(router);
  }
}

GoRoute getDefaultGoRoute({
  required String path,
  required String name,
  required Widget child,
}) {
  return GoRoute(
    path: path,
    name: name,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return getDefaultTransitionPage(key: state.pageKey, child: child);
    },
  );
}

Page<T> getDefaultTransitionPage<T>({LocalKey? key, required Widget child}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
