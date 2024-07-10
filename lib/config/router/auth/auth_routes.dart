import 'package:go_router/go_router.dart';
import 'package:orders_app/config/router/common_router.dart';
import 'package:orders_app/ui/features/auth/login_page.dart';
import 'package:orders_app/ui/features/auth/register_page.dart';

part 'auth_routes_texts.dart';

class AuthRoutes {
  final GoRoute loginRoute;
  final GoRoute registerRoute;

  const AuthRoutes._(this.loginRoute, this.registerRoute);

  factory AuthRoutes() {
    final GoRoute loginRoute = _buildLoginRoute();
    final GoRoute registerRoute = _buildRegisterRoute();
    return AuthRoutes._(loginRoute, registerRoute);
  }

  /// Construye la ruta para el inicio de sesion.
  static GoRoute _buildLoginRoute() {
    return getDefaultGoRoute(
      path: kLoginPath,
      name: kLoginPathName,
      child: const LoginPage(),
    );
  }

  /// Construye la ruta para el registro de cuenta.
  static GoRoute _buildRegisterRoute() {
    return getDefaultGoRoute(
      path: kRegisterPath,
      name: kRegisterPathName,
      child: const RegisterPage(),
    );
  }
}
