import 'dart:math';

import 'package:orders_app/data/datasources/auth_datasource.dart';
import 'package:orders_app/domain/entities/user.dart';

class AuthLocalDatasource extends AuthDatasource {
  @override
  User? checkSession() {
    return _userInSession;
  }

  @override
  Future<User?> onLogin({
    required String email,
    required String password,
  }) async {
    final loguedUser = _usersMock.where((u) => u.email == email).firstOrNull;

    _userInSession = loguedUser;
    return loguedUser;
  }

  @override
  Future<User?> onRegister({
    required String email,
    required String password,
  }) async {
    if (_usersMock.any((u) => u.email == email)) {
      return Future.value(null);
    }
    final userId = Random(email.length).nextInt(1000).toString();
    final newUser = User(userId: userId, email: email);
    _usersMock.add(newUser);
    _userInSession = newUser;
    return newUser;
  }

  @override
  Future<bool> onLogout() async {
    _userInSession = null;
    return Future.value(true);
  }
}

User? _userInSession = _usersMock.firstOrNull;
List<User> _usersMock = [
  const User(userId: "1", email: "example@email.com"),
];
