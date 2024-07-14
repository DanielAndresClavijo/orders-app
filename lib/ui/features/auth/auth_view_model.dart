import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/domain/usecases/auth_use_case.dart';
import 'package:orders_app/injector/injector_providers.dart';

class AuthViewModelState {
  final String? email;
  final String? pass;
  final bool loading;

  const AuthViewModelState({
    this.email,
    this.pass,
    this.loading = false,
  });

  AuthViewModelState copyWith({
    final String? email,
    final String? pass,
    final bool? loading,
  }) {
    return AuthViewModelState(
      email: email ?? this.email,
      pass: pass ?? this.pass,
      loading: loading ?? this.loading,
    );
  }
}

class AuthViewModel extends StateNotifier<AuthViewModelState> {
  final AuthUseCase authUseCase;
  final ProviderContainer providerContainer;

  AuthViewModel({
    required this.authUseCase,
    required this.providerContainer,
  }) : super(const AuthViewModelState());

  /// Restaura las variables del estado a su estado inicial.
  void restoreVariable() {
    state = const AuthViewModelState();
  }

  Future<bool> onLogin({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(loading: true);
      final user = await authUseCase.onLogin(email: email, password: password);
      if (user == null) {
        providerContainer.read(appProvider.notifier).showAlert(
              message: "Credenciales invalidas.",
            );

        state = state.copyWith(loading: false);
        return Future.value(false);
      }
      providerContainer.read(appProvider.notifier).showInfo(
            message: "Has iniciado sesión con exito.",
          );
      state = state.copyWith(email: null, pass: null, loading: false);
      return Future.value(true);
    } catch (e) {
      providerContainer.read(appProvider.notifier).showError(
            message: "Ha ocurrido un error al intentar iniciar sesion, "
                "intentalo de nuevo mas tarde.",
          );
      state = state.copyWith(loading: false);
      return Future.value(false);
    }
  }

  Future<bool> onRegister(
      {required String email, required String password}) async {
    try {
      state = state.copyWith(loading: true);
      final user = await authUseCase.onRegister(
        email: email,
        password: password,
      );
      if (user == null) {
        providerContainer.read(appProvider.notifier).showAlert(
              message: "Datos incorrectos.",
            );
        state = state.copyWith(loading: false);
        return Future.value(false);
      }
      providerContainer.read(appProvider.notifier).showInfo(
            message: "Cuenta creada.",
          );

      state = state.copyWith(email: null, pass: null, loading: false);
      return Future.value(true);
    } catch (e) {
      providerContainer.read(appProvider.notifier).showError(
            message: "Ha ocurrido un error con el registro, "
                "intentalo de nuevo mas tarde.",
          );
      state = state.copyWith(loading: false);
      return Future.value(false);
    }
  }

  void onChangeEmailText(String email) {
    state = state.copyWith(email: email);
  }

  void onChangePassText(String pass) {
    state = state.copyWith(pass: pass);
  }
}
