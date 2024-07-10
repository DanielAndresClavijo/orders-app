import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/config/router/orders/orders_routes.dart';
import 'package:orders_app/ui/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  kOrdersHistoryPathName;
  runApp(const ProviderScope(child: OrdersApp()));
}
