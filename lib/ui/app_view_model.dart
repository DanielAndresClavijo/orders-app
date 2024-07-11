import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NotificationType { error, alert, info }

class AppViewModelState {
  final String message;
  final NotificationType type;
  final VoidCallback? callback;

  AppViewModelState(this.message, this.type, [this.callback]);
}

class AppViewModel extends StateNotifier<AppViewModelState?> {
  AppViewModel() : super(null);

  /// Muestra el mensaje [message] en una notificacion de error.
  ///
  /// Nota: Las notificaciones de error tienen la opcion de reintentar [onRetry]
  ///       en la notificacion se muestra un boton con icono, el cual ejecuta
  ///       el callback.
  void showError({required String message, VoidCallback? onRetry}) {
    state = AppViewModelState(message, NotificationType.error, onRetry);
  }

  /// Muestra el mensaje [message] en una notificacion de alerta.
  void showAlert({required String message}) {
    state = AppViewModelState(message, NotificationType.alert);
  }

  /// Muestra el mensaje [message] en una notificacion de informacion.
  void showInfo({required String message, VoidCallback? callback}) {
    state = AppViewModelState(message, NotificationType.info);
  }

  /// Setea la instancia de notificacion a null.
  void clear() {
    state = null;
  }
}
