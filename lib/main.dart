import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/config/app_config.dart';
import 'package:orders_app/injector/injector.dart';
import 'package:orders_app/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Este provider permite el acceso a cualquier otro provider fuera del scope
  /// de los widget Consumer.
  ///
  /// Se utiliza para acceder a las funciones de los ViewModel en otros viewModels
  /// por ejemplo, para mostrar una notificacion de error en un viewModel se
  /// requiere usar el provider del AppViewModel.
  final container = ProviderContainer();

  /// Se inicializa la configuracion de la app.
  ///
  /// Esta configuracion contiene datos estaticos para el acceso a servicios o
  /// configuguracion de la app.
  final AppConfig appConfig = AppConfig.initialize();

  /// Inicializacion de las dependdencias de la aplicacion.
  await Injector.initialize(appConfig: appConfig, providerContainer: container);

  runApp(UncontrolledProviderScope(
    container: container,
    child: const OrdersApp(),
  ));
}
