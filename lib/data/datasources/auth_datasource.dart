import 'package:orders_app/domain/entities/user.dart';

/// Fuente de datos de la autenticacion.
///
/// Contacte directamente con el cliente del servidor mediante esta entidad.
///
///  Nota: Utilizarla solo desde los repositorios.
abstract class AuthDatasource {
  Future<User?> checkSession();

  /// Autoriza a un usuario por [email] y [password]
  Future<User?> onLogin({required String email, required String password});

  /// Registra a un usuario por [email] y [password]
  Future<User?> onRegister({required String email, required String password});

  /// Cierra la sesion.
  Future<void> onLogout();
}
