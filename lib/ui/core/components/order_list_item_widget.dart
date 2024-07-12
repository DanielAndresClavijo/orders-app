import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:orders_app/config/assets.dart';
import 'package:orders_app/config/router/orders/orders_routes.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

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
        onTap: () {
          context.go("$kOrderDetailPath/${order.id}");
        },
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
                        style: context.font.titleLarge?.copyWith(height: 1),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "${order.products.length} artículos · \$${order.totalPrice}",
                        style: context.font.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        _getShipmentTypeText(),
                        style: context.font.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Text.rich(
                        TextSpan(
                          text: DateFormat("M").format(order.createdAt),
                          children: [
                            const TextSpan(text: " · "),
                            TextSpan(text: _getTypeOrderText()),
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
                _getAssetIconText(),
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 24),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }

  String _getAssetIconText() {
    if (order.isPromoLive) return Assets.promoLiveIcon;
    return Assets.lineRoundedConnectIcon;
  }

  String _getTypeOrderText() {
    switch (order.status) {
      case OrderStatus.pending:
        return "Pendiente";
      case OrderStatus.cancelled:
        return "Cancelado";
      case OrderStatus.completed:
        return "Completado";
      case OrderStatus.noShow:
      default:
        return "No presentado";
    }
  }

  /// Obtiene el texto para el tipo de oferta del pedido.
  String _getShipmentTypeText() {
    if (order.isPromoLive) return "Promo Live";
    return "Promo Live";
  }
}
