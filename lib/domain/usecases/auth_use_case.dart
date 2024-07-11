import 'package:orders_app/domain/entities/user.dart';
import 'package:orders_app/domain/repositories/auth_repository.dart';

abstract class AuthUseCase {
  /// Usuario con sesion activa.
  User? currentUser;

  /// Comprueba si hay alguna session activa.
  User? checkSession();

  /// Autoriza a un usuario por [email] y [password]
  Future<User?> onLogin({required String email, required String password});

  /// Registra a un usuario por [email] y [password]
  Future<User?> onRegister({required String email, required String password});

  /// Cierra la sesion.
  Future<void> onLogout();
}

class AuthUseCaseImpl extends AuthUseCase {
  final AuthRepository repository;
  User? _currentUser;

  @override
  User? get currentUser => _currentUser;

  AuthUseCaseImpl(this.repository);

  @override
  User? checkSession() {
    try {
      final result = repository.checkSession();
      _currentUser = result;
      return result;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User?> onLogin({
    required String email,
    required String password,
  }) async {
    try {
      final result = await repository.onLogin(
        email: email,
        password: password,
      );
      _currentUser = result;
      return Future.value(result);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<User?> onRegister({
    required String email,
    required String password,
  }) async {
    try {
      final result = await repository.onRegister(
        email: email,
        password: password,
      );
      _currentUser = result;
      return Future.value(result);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> onLogout() async {
    try {
      await repository.onLogout();
      _currentUser = null;
    } catch (e) {
      return Future.error(e);
    }
  }
}