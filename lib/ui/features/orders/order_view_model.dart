import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/domain/usecases/orders_use_case.dart';
import 'package:orders_app/injector/injector_providers.dart';

/// La cantidad de pedidos que se pueden mostrar por paginación.
const List<int> kPageSize = [5, 10, 25, 50];

class OrderListViewModelState {
  /// Numero de la paginacion actual en la que se esta mostrando los pedidos.
  final int currentPageFilter;

  /// Filtro para guardar la canntidad de items mostrados por página.
  final int pageSizeFilter;

  /// Numero total de la paginacion de los pedidos.
  final int totalPage;

  /// Numero total pedidos.
  final int totalOrders;

  /// Filtro de estado de pedidos.
  final OrderStatus? statusFilter;

  /// Pedidos a mostrar.
  final List<Order> orders;

  const OrderListViewModelState({
    required this.currentPageFilter,
    required this.pageSizeFilter,
    required this.totalPage,
    required this.totalOrders,
    this.statusFilter,
    required this.orders,
  });

  OrderListViewModelState copyWith({
    final int? currentPageFilter,
    final int? pageSizeFilter,
    final int? totalPage,
    final int? totalOrders,
    final OrderStatus? statusFilter,
    final List<Order>? orders,
  }) {
    return OrderListViewModelState(
      currentPageFilter: currentPageFilter ?? this.currentPageFilter,
      pageSizeFilter: pageSizeFilter ?? this.pageSizeFilter,
      totalPage: totalPage ?? this.totalPage,
      totalOrders: totalOrders ?? this.totalOrders,
      statusFilter: statusFilter ?? this.statusFilter,
      orders: orders ?? this.orders,
    );
  }
}

class OrderListViewModel extends StateNotifier<OrderListViewModelState> {
  final OrdersUseCase ordersUseCase;
  final ProviderContainer providerContainer;
  final String _baseStorageUrl;

  OrderListViewModel({
    required this.ordersUseCase,
    required this.providerContainer,
    required String baseStorageUrl,
  })  : _baseStorageUrl = baseStorageUrl,
        super(OrderListViewModelState(
          currentPageFilter: 1,
          pageSizeFilter: kPageSize.first,
          totalPage: 1,
          totalOrders: 0,
          orders: [],
        ));

  String getOrderPublicUrl(String imageUrl) {
    return "$_baseStorageUrl$imageUrl";
  }

  Future<void> getOrders({
    required final int nextPage,
    required final int showItemCount,
    final OrderStatus? status,
  }) async {
    try {
      final offset = _calculateOffsetPages(nextPage, showItemCount);
      final (totalOrders, newOrders) = await ordersUseCase.getAll(
        offset: offset,
        limit: showItemCount,
        status: status,
      );
      final totalPage = _calculateTotalPages(totalOrders, showItemCount);
      state = state.copyWith(
        orders: newOrders,
        totalPage: totalPage,
        currentPageFilter: nextPage,
        statusFilter: status,
        pageSizeFilter: showItemCount,
        totalOrders: totalOrders,
      );
    } catch (e) {
      debugPrint("$e");
      _onError("No se pudo obtener los pedidos");
    }
  }

  int _calculateTotalPages(int totalOrders, int showItemCount) {
    final totalPage = (totalOrders / showItemCount).ceil();
    return totalPage;
  }

  int _calculateOffsetPages(int currentPageFilter, int sizePage) {
    int offset = (currentPageFilter - 1) * sizePage;
    if (offset < 0) return 0;
    return offset;
  }

  void filterByStatus(OrderStatus? status) async {
    if (status == state.statusFilter) status = null;

    final (totalOrders, newOrders) = await ordersUseCase.getAll(
      offset: 0,
      status: status,
      limit: state.pageSizeFilter,
    );
    final totalPage = _calculateTotalPages(totalOrders, state.pageSizeFilter);
    state = OrderListViewModelState(
      pageSizeFilter: state.pageSizeFilter,
      statusFilter: status,
      totalPage: totalPage,
      currentPageFilter: 1,
      orders: newOrders,
      totalOrders: totalOrders,
    );
  }

  void filterByPageNumber(final int page) async {
    final offset = _calculateOffsetPages(page, state.pageSizeFilter);
    final (totalOrders, newOrders) = await ordersUseCase.getAll(
      offset: offset,
      status: state.statusFilter,
      limit: state.pageSizeFilter,
    );
    final totalPage = _calculateTotalPages(totalOrders, state.pageSizeFilter);
    state = state.copyWith(
      currentPageFilter: page,
      totalPage: totalPage,
      orders: newOrders,
      totalOrders: totalOrders,
    );
  }

  void filterBySizePage(final int sizePage) async {
    int offset = _calculateOffsetPages(state.currentPageFilter, sizePage);
    if (offset > state.totalOrders) {
      final totalPage = _calculateTotalPages(state.totalOrders, sizePage);
      offset = _calculateOffsetPages(totalPage, sizePage);
    }
    final (totalOrders, newOrders) = await ordersUseCase.getAll(
      offset: offset,
      limit: sizePage,
      status: state.statusFilter,
    );
    final totalPage = _calculateTotalPages(totalOrders, sizePage);
    final currentPageFilter =
        state.currentPageFilter > totalPage ? totalPage : null;
    state = state.copyWith(
      pageSizeFilter: sizePage,
      totalPage: totalPage,
      currentPageFilter: currentPageFilter,
      orders: newOrders,
      totalOrders: totalOrders,
    );
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