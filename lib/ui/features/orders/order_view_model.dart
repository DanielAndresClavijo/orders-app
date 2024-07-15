import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/domain/usecases/orders_use_case.dart';
import 'package:orders_app/injector/injector_providers.dart';

/// La cantidad de pedidos que se pueden mostrar por paginación.
const List<int> kPageCount = [10, 25, 50];

class OrderListViewModelState {
  /// Numero de la paginacion actual en la que se esta mostrando los pedidos.
  final int currentPage;

  /// Numero total de la paginacion de los pedidos.
  final int totalPage;

  /// Pedidos a mostrar.
  final List<Order> orders;

  const OrderListViewModelState({
    this.currentPage = 1,
    this.totalPage = 1,
    required this.orders,
  });

  OrderListViewModelState copyWith({
    final int? currentPage,
    final int? totalPage,
    final List<Order>? orders,
  }) {
    return OrderListViewModelState(
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      orders: orders ?? this.orders,
    );
  }
}

class OrderListViewModel extends StateNotifier<OrderListViewModelState> {
  final OrdersUseCase ordersUseCase;
  final ProviderContainer providerContainer;

  OrderListViewModel({
    required this.ordersUseCase,
    required this.providerContainer,
  }) : super(const OrderListViewModelState(orders: []));

  Future<void> getOrders({
    required final int nextPage,
    required final int showItemCount,
    final OrderStatus? status,
  }) async {
    try {
      final offset = (nextPage <= 1 ? 1 : nextPage * showItemCount) - 1;
      final (totalOrders, newOrders) = await ordersUseCase.getAll(
        offset: offset,
        limit: showItemCount,
        status: status,
      );
      final totalPage = (totalOrders / showItemCount).ceil();
      state = state.copyWith(
        orders: newOrders,
        totalPage: totalPage,
        currentPage: nextPage,
      );
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
    providerContainer.read(appProvider.notifier).showError(
          message: error,
        );
  }
}
