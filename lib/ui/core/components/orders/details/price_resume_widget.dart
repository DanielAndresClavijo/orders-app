import 'package:flutter/material.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

/// Diseño para el resume de precio de los productos del pedido en la página detalles.
class PriceResumeWidget extends StatelessWidget {
  final String labelDescription;
  final String price;
  final Color? color;
  final bool iFontBold;

  const PriceResumeWidget(
      {super.key,
      required this.labelDescription,
      required this.price,
      this.color,
      this.iFontBold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            labelDescription,
            overflow: TextOverflow.ellipsis,
            style: context.font.bodyMedium?.copyWith(
              color: color,
              fontWeight: iFontBold ? FontWeight.w700 : null,
            ),
          ),
        ),
        Text(
          price,
          style: context.font.bodyMedium?.copyWith(
            color: color,
            fontWeight: iFontBold ? FontWeight.w700 : null,
          ),
        ),
      ],
    );
  }
}
