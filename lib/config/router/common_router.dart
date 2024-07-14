import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/navigation_history.dart';
import 'package:orders_app/config/router/auth/auth_routes.dart';
import 'package:orders_app/config/router/orders/orders_routes.dart';
import 'package:orders_app/config/router/welcome/welcome_routes.dart';
import 'package:orders_app/domain/usecases/auth_use_case.dart';
import 'package:orders_app/ui/core/components/base/unauthorized_user_base_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell1');

final _getIt = GetIt.instance;

/// Enrutador para las páginas de la aplicacion.
class CommonRouter {
  final GoRouter router;

  const CommonRouter._(this.router);

  factory CommonRouter() {
    final navigationHistory = _getIt<NavigationHistory>();
    final authUseCase = _getIt<AuthUseCase>();
    final AuthRoutes authRoutes = AuthRoutes();
    final WelcomeRoutes welcomeRoutes = WelcomeRoutes();
    final OrdersRoutes ordersRoutes = OrdersRoutes(navigationHistory);

    final GoRouter router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: welcomeRoutes.splashRoute.path,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        return _redirect(context, state, navigationHistory, authUseCase);
      },
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

Future<String?> _redirect(
  BuildContext context,
  GoRouterState state,
  NavigationHistory navigationHistory,
  AuthUseCase authUseCase,
) {
  navigationHistory.push(state.uri.path);
  final userInSession = authUseCase.checkSession();
  if (state.uri.path.startsWith(kOrderBasePath) && userInSession == null) {
    return Future.value(kLoginPath);
  }
  if ((state.uri.path.startsWith(kLoginPath) ||
          state.uri.path.startsWith(kRegisterPath)) &&
      userInSession != null) {
    return Future.value(kOrdersListPath);
  }
  return Future.value(null);
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
