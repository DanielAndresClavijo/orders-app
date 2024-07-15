import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:orders_app/config/app_config.dart';
import 'package:orders_app/config/theme.dart';
import 'package:orders_app/domain/usecases/auth_use_case.dart';
import 'package:orders_app/domain/usecases/orders_use_case.dart';
import 'package:orders_app/ui/app_view_model.dart';
import 'package:orders_app/ui/features/auth/auth_view_model.dart';
import 'package:orders_app/ui/features/orders/order_view_model.dart';

final GetIt _getIt = GetIt.instance;

final themeNotifierProvider = ChangeNotifierProvider<ThemeNotifier>((ref) {
  return ThemeNotifier();
});

final orderListNotifierProvider =
    StateNotifierProvider<OrderListViewModel, OrderListViewModelState>(
  (ref) {
    return OrderListViewModel(
      ordersUseCase: _getIt<OrdersUseCase>(),
      providerContainer: _getIt<ProviderContainer>(),
      baseStorageUrl:
          "${_getIt<AppConfig>().supabaseUrl}/storage/v1/object/public/product%20image/",
    );
  },
);

final authNotifierProvider =
    StateNotifierProvider<AuthViewModel, AuthViewModelState>((ref) {
  return AuthViewModel(
    authUseCase: _getIt<AuthUseCase>(),
    providerContainer: _getIt<ProviderContainer>(),
  );
});
final appProvider =
    StateNotifierProvider<AppViewModel, AppViewModelState?>((ref) {
  return AppViewModel();
});
