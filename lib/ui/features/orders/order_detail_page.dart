import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

class OrderDetailPage extends ConsumerStatefulWidget {
  final int orderId;

  const OrderDetailPage({
    super.key,
    required this.orderId,
  });

  @override
  ConsumerState<OrderDetailPage> createState() => _OrderDetailState();
}

class _OrderDetailState extends ConsumerState<OrderDetailPage> {
  Order? _order;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(orderListNotifierProvider.notifier)
          .getOrderDetails(widget.orderId)
          .then(
        (order) async {
          _order = order;
          loading = false;
          setState(() {});
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: context.color.onSurface,
          ),
        ),
      );
    }
    if (_order == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Pedido no encontrado",
            style: context.font.headlineSmall,
          ),
        ),
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(16),
              ),
              height: 180,
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  Text(_order!.companyName),
                  Text(_order!.companyName),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
