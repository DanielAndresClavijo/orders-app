import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orders_app/config/assets.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/core/components/orders/details/direct_type_widget.dart';
import 'package:orders_app/ui/core/components/orders/details/promo_type_widget.dart';
import 'package:orders_app/ui/core/constants_app.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';
import 'package:orders_app/ui/core/extensions/date_time_extension.dart';
import 'package:orders_app/ui/core/extensions/order_extension.dart';

/// Página que muestra los detalles de algún pedido, según [orderId].
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
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.only(bottom: 16),
          constraints: const BoxConstraints(
            maxWidth: kWidthPage,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAlias,
                height: 180,
                child: Image.network(
                  ref
                      .read(orderListNotifierProvider.notifier)
                      .getOrderPublicUrl(_order?.imageId ?? ""),
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      Assets.staticOrderImage,
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: Material(
                  color: context.theme.cardColor,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          _order!.companyName,
                          style: context.font.headlineSmall,
                        ),
                        Text.rich(
                          TextSpan(
                            text: "",
                            children: [
                              TextSpan(
                                text: _order!.typeOrderText,
                                style: context.font.labelSmall?.copyWith(
                                  color: _order!.typeOrderColor,
                                ),
                              ),
                              const TextSpan(text: " · "),
                              TextSpan(
                                  text: _order!.updatedAt.monthDayAndHourText),
                            ],
                          ),
                          style: context.font.labelSmall,
                        ),
                        if (!_order!.isPromo)
                          Text.rich(
                            TextSpan(
                              text: "",
                              children: [
                                const WidgetSpan(
                                  child: Icon(Icons.location_on_outlined),
                                ),
                                const TextSpan(text: " "),
                                TextSpan(
                                    text:
                                        _order!.updatedAt.monthDayAndHourText),
                              ],
                            ),
                            style: context.font.labelSmall,
                          ),
                        const SizedBox(height: 32),
                        Text(
                          "Tu pedido",
                          style: context.font.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_order!.isPromo)
                                  PromoTypeWidget(order: _order!)
                                else
                                  DirectTypeWidget(order: _order!),
                                const SizedBox(height: 16),
                                Divider(
                                  height: 2,
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                const SizedBox(height: 32),
                                SizedBox(
                                  width: context.screenSize.width,
                                  child: Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    runAlignment: WrapAlignment.spaceBetween,
                                    children: [
                                      const Text("Método de pago"),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox.square(
                                            dimension: 48,
                                            child: SvgPicture.asset(
                                              _order!.paymentMethod ==
                                                      PaymentMethod.visa
                                                  ? Assets.visaLogo
                                                  : Assets.mastercardLogo,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "ICICI Bank Card",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  "************5486",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),
                                OutlinedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    foregroundColor: WidgetStatePropertyAll(
                                      context.color.onSurface,
                                    ),
                                    overlayColor: WidgetStatePropertyAll(
                                      context.color.onSurface.withOpacity(
                                        0.2,
                                      ),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: Text("Ver factura"),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                OutlinedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    foregroundColor: WidgetStatePropertyAll(
                                      context.color.onSurface,
                                    ),
                                    overlayColor: WidgetStatePropertyAll(
                                      context.color.onSurface.withOpacity(
                                        0.2,
                                      ),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: Text("¿Necesitas ayuda?"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}