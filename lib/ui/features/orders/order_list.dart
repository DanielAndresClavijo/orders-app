import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/core/components/product_list_widget.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

class OrderListPage extends ConsumerStatefulWidget {
  const OrderListPage({
    super.key,
  });

  @override
  ConsumerState<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends ConsumerState<OrderListPage> {
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderListNotifierProvider.notifier).getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    _orders = ref.watch(orderListNotifierProvider).orders;
    return Scaffold(
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_orders.isEmpty) {
      return Center(
        child: Text(
          "Nada que ver",
          style: context.font.displayLarge,
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 0,
            maxWidth: 940,
          ),
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Text(
                    "Pedidos anteriores",
                    style: context.font.bodyLarge,
                    textAlign: TextAlign.left,
                  ),
                ),
                Flexible(child: OrderListWidget(orders: _orders)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
