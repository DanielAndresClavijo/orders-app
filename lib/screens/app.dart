import 'package:flutter/material.dart';
import 'package:orders_app/config/router/common.dart';

class OrdersApp extends StatefulWidget {
  const OrdersApp({super.key});

  @override
  State<OrdersApp> createState() => _OrdersAppState();
}

class _OrdersAppState extends State<OrdersApp> {
  late CommonRouter router;

  @override
  void initState() {
    super.initState();
    router = CommonRouter();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Order App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      routerDelegate: router.router.routerDelegate,
      routeInformationParser: router.router.routeInformationParser,
      routeInformationProvider: router.router.routeInformationProvider,
    );
  }
}
