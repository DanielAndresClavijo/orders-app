import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/config/router/common_router.dart';
import 'package:orders_app/config/theme.dart';

class OrdersApp extends ConsumerStatefulWidget {
  const OrdersApp({super.key});

  @override
  ConsumerState<OrdersApp> createState() => _OrdersAppState();
}

class _OrdersAppState extends ConsumerState<OrdersApp> {
  late CommonRouter router;

  @override
  void initState() {
    super.initState();
    router = CommonRouter();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);
    return MaterialApp.router(
      title: 'Order App',
      theme: theme.theme,
      routerConfig: router.router,
    );
  }
}
