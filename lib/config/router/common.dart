import 'package:go_router/go_router.dart';
import 'package:orders_app/config/router/auth_routes.dart';
import 'package:orders_app/config/router/orders_routes.dart';
import 'package:orders_app/config/router/welcome_routes.dart';

/// Enrutador para las paginas de la aplicacion.
class CommonRouter {
  final GoRouter router;

  const CommonRouter._(this.router);

  factory CommonRouter() {
    final AuthRoutes authRoutes = AuthRoutes();
    final WelcomeRoutes welcomeRoutes = WelcomeRoutes();
    final OrdersRoutes ordersRoutes = OrdersRoutes();

    final GoRouter router = GoRouter(
      initialLocation: welcomeRoutes.homeRoute.path,
      routes: [
        welcomeRoutes.homeRoute,
        welcomeRoutes.splashRoute,
        authRoutes.loginRoute,
        authRoutes.registerRoute,
        ordersRoutes.routes,
      ],
    );
    return CommonRouter._(router);
  }
}
