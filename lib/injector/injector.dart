import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:orders_app/config/app_config.dart';
import 'package:orders_app/config/navigation_history.dart';
import 'package:orders_app/data/datasources/auth_datasource.dart';
import 'package:orders_app/data/datasources/local/auth_local_datasource.dart';
import 'package:orders_app/data/datasources/local/orders_local_datasource.dart';
import 'package:orders_app/data/datasources/orders_datasource.dart';
import 'package:orders_app/data/datasources/supabase_impl/auth_supabase_datasource.dart';
import 'package:orders_app/data/datasources/supabase_impl/orders_supabase_datasource.dart';
import 'package:orders_app/data/repositories_impl/auth_repository_impl.dart';
import 'package:orders_app/data/repositories_impl/orders_repository_impl.dart';
import 'package:orders_app/domain/repositories/auth_repository.dart';
import 'package:orders_app/domain/repositories/orders_repository.dart';
import 'package:orders_app/domain/usecases/auth_use_case.dart';
import 'package:orders_app/domain/usecases/orders_use_case.dart';
import 'package:orders_app/ui/core/components/navigation_history.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Injector {
  final GetIt _getIt = GetIt.instance;

  Injector._();

  /// Registra todas las instancias requeridas.
  ///
  /// Esto deberia utilizarse una sola vez, de lo contrario habra un error.
  static Future<Injector> initialize({
    required AppConfig appConfig,
    required ProviderContainer providerContainer,
  }) async {
    final instance = Injector._();
    SupabaseClient? client;

    if (appConfig.clientEnvironment == ClientEnvironment.fromBaaS) {
      final supabase = await Supabase.initialize(
        url: appConfig.supabaseUrl,
        anonKey: appConfig.supabaseKey,
      );

      client = supabase.client;
    }

    instance._initialize(appConfig, providerContainer, client);
    return Future.value(instance);
  }

  void _initialize(
    AppConfig appConfig,
    ProviderContainer providerContainer, [
    SupabaseClient? client,
  ]) {
    _getIt.registerSingleton<ProviderContainer>(providerContainer);

    /// Registro de configuracion de la app.
    _getIt.registerSingleton<AppConfig>(appConfig);

    /// Registro del historial de navegación de la app.
    _registerNavigationHistory();

    if (client != null) {
      /// Registro de Datasource con cliente Supabase.
      _registerAuthSupabaseDatasource(client);
      _registerOrdersSupabaseDatasource(client);
    } else {
      /// Registro de Datasource entorno local.
      _registerAuthLocalDatasource();
      _registerOrdersLocalDatasource();
    }

    /// Registro de repositorios.
    _registerAuthRepository();
    _registerOrdersRepository();

    /// Registro de UseCase.
    _registerAuthUseCase();
    _registerOrdersUseCase();
  }

  void _registerAuthSupabaseDatasource(SupabaseClient client) {
    _getIt.registerFactory<AuthDatasource>(
      () => AuthSupabaseDatasource(client),
    );
  }

  void _registerNavigationHistory() {
    _getIt.registerSingleton<NavigationHistory>(NavigationHistory());
  }

  void _registerAuthLocalDatasource() {
    _getIt.registerFactory<AuthDatasource>(
      () => AuthLocalDatasource(),
    );
  }

  void _registerOrdersSupabaseDatasource(SupabaseClient client) {
    final orderTableName = _getIt<AppConfig>().orderTableName;
    _getIt.registerFactory<OrdersDatasource>(
      () => OrdersSupabaseDatasource(client, orderTableName),
    );
  }

  void _registerOrdersLocalDatasource() {
    _getIt.registerFactory<OrdersDatasource>(
      () => OrdersLocalDatasource(),
    );
  }

  void _registerAuthRepository() {
    _getIt.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(_getIt<AuthDatasource>()),
    );
  }

  void _registerOrdersRepository() {
    _getIt.registerFactory<OrdersRepository>(
      () => OrdersRepositoryImpl(_getIt<OrdersDatasource>()),
    );
  }

  void _registerAuthUseCase() {
    _getIt.registerLazySingleton<AuthUseCase>(
      () => AuthUseCaseImpl(_getIt<AuthRepository>()),
    );
  }

  void _registerOrdersUseCase() {
    _getIt.registerLazySingleton<OrdersUseCase>(
      () => OrdersUseCaseImpl(_getIt<OrdersRepository>()),
    );
  }
}