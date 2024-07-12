import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/domain/usecases/orders_use_case.dart';
import 'package:orders_app/injector/injector_providers.dart';

class OrderListViewModelState {
  final List<Order> orders;

  const OrderListViewModelState({
    required this.orders,
  });

  OrderListViewModelState copyWith({
    List<Order>? orders,
  }) {
    return OrderListViewModelState(
      orders: orders ?? this.orders,
    );
  }
}

class OrderListViewModel extends StateNotifier<OrderListViewModelState> {
  final OrdersUseCase ordersUseCase;
  final ProviderContainer providerContainer;

  OrderListViewModel(
      {required this.ordersUseCase, required this.providerContainer, required})
      : super(const OrderListViewModelState(orders: []));

  Future<void> getOrders() async {
    try {
      final newOrders = await ordersUseCase.getAll();
      state = state.copyWith(orders: newOrders);
    } catch (e) {
      debugPrint("$e");
      _onError("No se pudo obtener los pedidos");
    }
  }

  Future<Order?> getOrderDetails(int orderId) async {
    try {
      final newOrder = await ordersUseCase.get(orderId);
      return Future.value(newOrder);
    } catch (e) {
      debugPrint("$e");
      _onError("No se pudo obtener los detalles pedidos");
      return Future.error(e);
    }
  }

  void _onError(String error) {
    providerContainer.read(appNotifierProvider.notifier).showError(
          message: error,
        );
  }
}
