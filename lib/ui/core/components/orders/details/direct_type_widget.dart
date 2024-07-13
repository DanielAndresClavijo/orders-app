import 'package:flutter/material.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/ui/core/components/orders/details/price_resume_widget.dart';
import 'package:orders_app/ui/core/components/orders/list/product_order_item_widget.dart';

/// Widget para el diseño en la página de detalles de pedido cuando el pedido
/// es de tipo [OrderType.direct]
class DirectTypeWidget extends StatelessWidget {
  final Order order;

  const DirectTypeWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var product in order.products)
          SizedBox(
            height: 56,
            child: ProductOrderItemWidget(productOrder: product),
          ),
        const SizedBox(height: 32),
        PriceResumeWidget(
          labelDescription: "Total de los artículos",
          price: "\$${order.totalProductPrice.toStringAsFixed(2)}",
        ),
        PriceResumeWidget(
          labelDescription: "Descuentos",
          price: "-\$"
              "${order.totalProductPriceDiscount.toStringAsFixed(2)}",
          color: Colors.green,
        ),
        PriceResumeWidget(
          labelDescription: "Envío",
          price: "\$${order.shipment.toStringAsFixed(2)}",
        ),
        PriceResumeWidget(
          labelDescription: "Propina",
          price: "\$${order.tip.toStringAsFixed(2)}",
        ),
        PriceResumeWidget(
          labelDescription: "Total pagado",
          price: "\$${order.totalPrice.toStringAsFixed(2)}",
          iFontBold: true,
        ),
      ],
    );
  }
}
