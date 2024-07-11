import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/config/app_config.dart';
import 'package:orders_app/injector/injector.dart';
import 'package:orders_app/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  final AppConfig appConfig = AppConfig.initialize();

  await Injector.initialize(appConfig: appConfig, providerContainer: container);

  runApp(UncontrolledProviderScope(
    container: container,
    child: const OrdersApp(),
  ));
}
