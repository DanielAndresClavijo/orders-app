import 'package:orders_app/data/datasources/auth_datasource.dart';
import 'package:orders_app/domain/entities/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show SupabaseClient;

class AuthSupabaseDatasource extends AuthDatasource {
  final SupabaseClient client;

  AuthSupabaseDatasource(this.client);

  @override
  Future<User?> checkSession() async {
    final response = client.auth.currentSession?.user;

    final newUser = response != null
        ? User(userId: response.id, email: response.email!)
        : null;

    return Future.value(newUser);
  }

  @override
  Future<User?> onLogin({
    required String email,
    required String password,
  }) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final newUser = response.user != null
        ? User(userId: response.user!.id, email: response.user!.email!)
        : null;
    return Future.value(newUser);
  }

  @override
  Future<User?> onRegister({
    required String email,
    required String password,
  }) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
    );

    final newUser = response.user != null
        ? User(userId: response.user!.id, email: response.user!.email!)
        : null;

    return Future.value(newUser);
  }

  @override
  Future<void> onLogout() async {
    await client.auth.signOut();
  }
}
