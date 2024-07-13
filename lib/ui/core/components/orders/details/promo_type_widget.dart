import 'package:flutter/material.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/ui/core/components/orders/details/price_resume_widget.dart';

/// Widget para el diseño en la página de detalles de pedido cuando el pedido
/// es de tipo [OrderType.promo]
class PromoTypeWidget extends StatelessWidget {
  final Order order;

  const PromoTypeWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        PriceResumeWidget(
          labelDescription: "Total de los artículos",
          price: _getPriceTotal(),
        ),
        const SizedBox(height: 16),
        PriceResumeWidget(
          labelDescription: "Total pagado",
          price: _getPriceTotal(),
          iFontBold: true,
        ),
      ],
    );
  }

  String _getPriceTotal() {
    if (order.status == OrderStatus.noShow) return "\$500.00";
    return "\$0.00";
  }
}
