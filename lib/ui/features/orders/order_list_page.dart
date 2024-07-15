import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/core/components/orders/list/order_list_widget.dart';
import 'package:orders_app/ui/core/constants_app.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';
import 'package:orders_app/ui/features/orders/order_view_model.dart';

/// Página donde se listan las ordenes.
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
      ref.read(orderListNotifierProvider.notifier).getOrders(
            nextPage: 1,
            showItemCount: kPageSize.first,
          );
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Nada que mostrar",
            style: context.font.headlineLarge,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 0,
              maxWidth: kWidthPage,
            ),
            child: Material(
              color: context.theme.cardColor,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      "Pedidos anteriores",
                      style: context.font.titleMedium,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Flexible(child: OrderListWidget(orders: _orders)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
