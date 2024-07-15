import 'package:flutter/material.dart';
import 'package:orders_app/data/datasources/orders_datasource.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  final OrdersDatasource datasource;

  OrdersRepositoryImpl(this.datasource);

  @override
  Future<Order?> get(int id) async {
    try {
      final result = await datasource.get(id);
      return Future.value(result);
    } catch (e) {
      debugPrint("Error OrdersRepositoryImpl.get: $e");
      return Future.error(e);
    }
  }

  @override
  Future<(int count, List<Order> orders)> getAll({
    final OrderStatus? status,
    final int? limit,
    final int? offset,
  }) async {
    try {
      final result = await datasource.getAll(
        status: status,
        limit: limit,
        offset: offset,
      );
      return Future.value(result);
    } catch (e) {
      debugPrint("Error OrdersRepositoryImpl.getAll: $e");
      return Future.error(e);
    }
  }
}
