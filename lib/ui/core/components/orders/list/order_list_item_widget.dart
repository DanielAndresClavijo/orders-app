import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/router/orders/orders_routes.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';
import 'package:orders_app/ui/core/extensions/date_time_extension.dart';
import 'package:orders_app/ui/core/extensions/order_extension.dart';

/// Widget que representa cada item de la lista de pedidos.
class OrderListItemWidget extends StatelessWidget {
  final Order order;

  const OrderListItemWidget({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: InkWell(
        onTap: () => context.go("$kOrderDetailPath/${order.id}"),
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Colors.yellow,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              order.companyName,
                              style:
                                  context.font.titleLarge?.copyWith(height: 1),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "${order.products.length} artículos · \$${order.totalPrice.toStringAsFixed(2)}",
                              style: context.font.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              order.shipmentTypeText,
                              style: context.font.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            child: Text.rich(
                              TextSpan(
                                text: order.createdAt.monthAndDayText,
                                children: [
                                  const TextSpan(text: " · "),
                                  TextSpan(
                                    text: order.typeOrderText,
                                    style: context.font.bodyMedium?.copyWith(
                                      color: order.typeOrderColor,
                                    ),
                                  ),
                                ],
                              ),
                              style: context.font.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      order.assetOrderTypeIconText,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 24),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            Divider(
              height: 20,
              thickness: 2,
              indent: 16,
              endIndent: 16,
              color: Colors.grey.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}
