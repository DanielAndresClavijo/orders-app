import 'package:orders_app/data/datasources/auth_datasource.dart';
import 'package:orders_app/domain/entities/user.dart';
import 'package:orders_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  User? checkSession() {
    try {
      final result = datasource.checkSession();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> onLogin({
    required String email,
    required String password,
  }) async {
    try {
      final result = await datasource.onLogin(
        email: email,
        password: password,
      );
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
      final result = await datasource.onRegister(
        email: email,
        password: password,
      );
      return Future.value(result);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> onLogout() async {
    try {
      await datasource.onLogout();
    } catch (e) {
      return Future.error(e);
    }
  }
}
