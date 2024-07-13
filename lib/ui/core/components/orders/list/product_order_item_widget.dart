import 'package:flutter/material.dart';
import 'package:orders_app/domain/entities/product_order.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

class ProductOrderItemWidget extends StatelessWidget {
  final ProductOrder productOrder;

  const ProductOrderItemWidget({
    super.key,
    required this.productOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 28,
                          minHeight: 28,
                        ),
                        color: context.color.error,
                        child: Text(
                          "x${productOrder.count}",
                          style: context.font.labelSmall?.copyWith(
                            color: context.color.onError,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        productOrder.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: "",
                      children: [
                        TextSpan(
                          text: "\$${productOrder.totalPrice.toInt()}",
                          style: context.font.bodySmall?.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: "  "
                              "\$${productOrder.totalPriceWithDiscount.toInt()}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: Colors.grey.withOpacity(0.2),
        ),
      ],
    );
  }
}
