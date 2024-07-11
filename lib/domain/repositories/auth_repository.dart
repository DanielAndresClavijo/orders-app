import 'package:orders_app/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> checkSession();

  Future<User?> onLogin({required String email, required String password});

  Future<User?> onRegister({required String email, required String password});

  Future<void> onLogout();
}
