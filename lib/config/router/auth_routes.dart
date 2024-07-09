import 'package:go_router/go_router.dart';
import 'package:orders_app/screens/auth/login_page.dart';
import 'package:orders_app/screens/auth/register_page.dart';

/// # Ruta para navegar al inicio de sesion.
///
///  __Ruta `/login`__
const String kLoginPath = "/login";

/// # Nombre de Ruta para navegar al inicio de sesion.
///
///  Nota: El nombre de ruta se usa como identificador unico de la ruta, que
///  en algunas ocasiones puede ser util para cuando se navega por nombre.
///
///  __Nombre de Ruta `loginPathName`__
const String kLoginPathName = "loginPathName";

/// # Ruta para navegar al registro de cuenta.
///
///  __Ruta `/register`__
const String kRegisterPath = "/register";

/// # Nombre de Ruta para navegar al registro de cuenta.
///
///  Nota: El nombre de ruta se usa como identificador unico de la ruta, que
///  en algunas ocasiones puede ser util para cuando se navega por nombre.
///
///  __Nombre de Ruta `registerPathName`__
const String kRegisterPathName = "registerPathName";

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
    return GoRoute(
      path: kLoginPath,
      name: kLoginPathName,
      builder: (context, state) => const LoginPage(),
    );
  }

  /// Construye la ruta para el registro de cuenta.
  static GoRoute _buildRegisterRoute() {
    return GoRoute(
      path: kRegisterPath,
      name: kRegisterPathName,
      builder: (context, state) => const RegisterPage(),
    );
  }
}
