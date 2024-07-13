import 'package:orders_app/config/router/auth/auth_routes.dart';
import 'package:orders_app/config/router/orders/orders_routes.dart';
import 'package:orders_app/config/router/welcome/welcome_routes.dart';

/// Clase de configuracion del historial de navegación.
class NavigationHistory {
  final List<String> _history = [];

  /// Agrega una ruta al historial de navegación.
  void push(String path) {
    if (_history.lastOrNull == path) return;
    if (_history.isEmpty) {
      if (path == kHomePath) _history.add(kSplashPath);
      if (path == kLoginPath) _history.add(kHomePath);
      if (path == kRegisterPath) _history.add(kLoginPath);
      if (path == kOrdersListPath) _history.add(kHomePath);
      if (path.startsWith(kOrderDetailPath)) _history.add(kOrdersListPath);
    }
    _history.add(path);
  }

  /// Retorna la penultima ruta del historia y elimina la ultima.
  String get popPath {
    if (_history.isNotEmpty) {
      final removedPath = _history.removeLast();
      final starsWithLoginPath =
          _history.lastOrNull?.startsWith(kLoginPath) ?? false;
      final starsWithRegisterPath =
          _history.lastOrNull?.startsWith(kRegisterPath) ?? false;
      if ((starsWithLoginPath || starsWithRegisterPath) &&
          removedPath.startsWith(kOrderBasePath)) {
        _history.removeWhere(
          (path) =>
              path.startsWith(kLoginPath) || path.startsWith(kRegisterPath),
        );
      }
      final destinationPath = _history.lastOrNull ?? kHomePath;
      if (destinationPath == kSplashPath) return kHomePath;
      return destinationPath;
    }

    return kHomePath;
  }

  List<String> get history => List.unmodifiable(_history);
}