import 'package:orders_app/data/datasources/orders_datasource.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersSupabaseDatasource extends OrdersDatasource {
  final SupabaseClient client;
  final String orderTableName;

  OrdersSupabaseDatasource(this.client, this.orderTableName);

  @override
  Future<Order?> get(int id) async {
    final response = await client
        .from(orderTableName)
        .select('*, product_order(*)')
        .eq('id', id)
        .single();
    print("OrdersSupabaseDatasource.get: $response");
    final foundedOrder = Order.fromJson(response);
    return Future.value(foundedOrder);
  }

  @override
  Future<List<Order>> getAll() async {
    final response = await client.rpc('get_orders_with_products');
    if (response is! List) return Future.error("Not found");
    print(response);
    print("##############OrdersSupabaseDatasource.getAll###################");
    response.map((e) => print(e));
    print("##############OrdersSupabaseDatasource.getAll###################");
    final result = response.map((o) => Order.fromJson(o));
    return Future.value(result.toList());
  }
}
