import 'package:flutter/material.dart';
import 'package:orders_app/data/datasources/orders_datasource.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersSupabaseDatasource extends OrdersDatasource {
  final SupabaseClient client;
  final String orderTableName;

  OrdersSupabaseDatasource(this.client, this.orderTableName);

  @override
  Future<Order?> get(int id) async {
    try {
      final response = await client.rest
          .rpc("get_orders_with_products", params: {'p_order_id': id}).single();
      final foundedOrder = Order.fromJson(response);
      return Future.value(foundedOrder);
    } on PostgrestException catch (e) {
      debugPrint("ERROR OrdersSupabaseDatasource.getAll: $e");
      return Future.error(e.code.toString());
    } catch (e) {
      debugPrint("ERROR OrdersSupabaseDatasource.getAll: $e");
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
      final response = await client.rest.rpc(
        "get_orders_with_products",
        params: {
          'p_status': status?.name,
          'p_limit': limit,
          'p_offset': offset,
        },
      );
      if (response is! List) return Future.error("Not found");
      final result = response.map((o) => Order.fromJson(o));
      int count = int.tryParse("${response.firstOrNull?["total_count"]}") ?? 0;
      if (count < result.length) count = result.length;

      return Future.value((count, result.toList()));
    } on PostgrestException catch (e) {
      debugPrint("ERROR OrdersSupabaseDatasource.getAll: $e");
      return Future.error(e.code.toString());
    } catch (e) {
      debugPrint("ERROR OrdersSupabaseDatasource.getAll: $e");
      return Future.error(e);
    }
  }
}
