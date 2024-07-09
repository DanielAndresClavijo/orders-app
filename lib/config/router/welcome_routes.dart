import 'package:go_router/go_router.dart';
import 'package:orders_app/screens/welcome/home_page.dart';
import 'package:orders_app/screens/welcome/splash_page.dart';

/// # Ruta para navegar a la página principal.
///
///  __Ruta `/home`__
const String kHomePath = "/";

/// # Nombre de Ruta para navegar a la página principal.
///
///  Nota: El nombre de ruta se usa como identificador unico de la ruta, que
///  en algunas ocasiones puede ser util para cuando se navega por nombre.
///
///  __Nombre de Ruta `homePathName`__
const String kHomePathName = "homePathName";

/// # Ruta para navegar a la página de carga.
///
///  __Ruta `/splash`__
const String kSplashPath = "/splash";

/// # Nombre de Ruta para navegar a la página de carga.
///
///  Nota: El nombre de ruta se usa como identificador unico de la ruta, que
///  en algunas ocasiones puede ser util para cuando se navega por nombre.
///
///  __Nombre de Ruta `splashPathName`__
const String kSplashPathName = "splashPathName";

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
    return GoRoute(
      path: kHomePath,
      name: kHomePathName,
      builder: (context, state) => const HomePage(),
    );
  }

  /// Construye la ruta para la pagina de carga.
  static GoRoute _buildSplashRoute() {
    return GoRoute(
      path: kSplashPath,
      name: kSplashPathName,
      builder: (context, state) => const SplashPage(),
    );
  }
}
