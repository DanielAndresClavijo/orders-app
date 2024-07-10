import 'package:go_router/go_router.dart';
import 'package:orders_app/config/router/common_router.dart';
import 'package:orders_app/ui/features/welcome/home_page.dart';
import 'package:orders_app/ui/features/welcome/splash_page.dart';

part 'welcome_routes_texts.dart';

class WelcomeRoutes {
  final GoRoute homeRoute;
  final GoRoute splashRoute;

  const WelcomeRoutes._(this.homeRoute, this.splashRoute);

  factory WelcomeRoutes() {
    final GoRoute homeRoute = _buildHomeRoute();
    final GoRoute splashRoute = _buildSplashRoute();
    return WelcomeRoutes._(homeRoute, splashRoute);
  }

  /// Construye la ruta para la pagina principal.
  static GoRoute _buildHomeRoute() {
    return getDefaultGoRoute(
      path: kHomePath,
      name: kHomePathName,
      child: const HomePage(),
    );
  }

  /// Construye la ruta para la pagina de carga.
  static GoRoute _buildSplashRoute() {
    return getDefaultGoRoute(
      path: kSplashPath,
      name: kSplashPathName,
      child: const SplashPage(),
    );
  }
}
