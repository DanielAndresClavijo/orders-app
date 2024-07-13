import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orders_app/config/assets.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/core/components/orders/product_order_item_widget.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';
import 'package:orders_app/ui/core/extensions/date_time_extension.dart';
import 'package:orders_app/ui/core/extensions/order_extension.dart';

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
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 940,
          ),
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
              Flexible(
                child: Card(
                  color: context.theme.cardColor,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: Colors.transparent,
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
                        Text.rich(
                          TextSpan(
                            text: "",
                            children: [
                              const WidgetSpan(
                                child: Icon(Icons.location_on_outlined),
                              ),
                              const TextSpan(text: " "),
                              TextSpan(
                                  text: _order!.updatedAt.monthDayAndHourText),
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
                                for (var product in _order!.products)
                                  SizedBox(
                                    height: 56,
                                    child: ProductOrderItemWidget(
                                        productOrder: product),
                                  ),
                                const SizedBox(height: 32),
                                _buildPriceResume(
                                  labelDescription: "Total de los artículos",
                                  price: _order!.totalProductPrice
                                      .toStringAsFixed(2),
                                ),
                                _buildPriceResume(
                                  labelDescription: "Descuentos",
                                  price: _order!.totalProductPriceDiscount
                                      .toStringAsFixed(2),
                                ),
                                _buildPriceResume(
                                  labelDescription: "Envío",
                                  price: _order!.shipment.toStringAsFixed(2),
                                ),
                                _buildPriceResume(
                                  labelDescription: "Propina",
                                  price: _order!.tip.toStringAsFixed(2),
                                ),
                                _buildPriceResume(
                                  labelDescription: "Total pagado",
                                  price: _order!.totalPrice.toStringAsFixed(2),
                                ),
                                const SizedBox(height: 16),
                                Divider(
                                  height: 2,
                                  thickness: 2,
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                const SizedBox(height: 32),
                                Flexible(
                                  child: Wrap(
                                    spacing: 8,
                                    alignment: WrapAlignment.start,
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
                                          SvgPicture.asset(
                                            _order!.paymentMethod ==
                                                    PaymentMethod.visa
                                                ? Assets.visaLogo
                                                : Assets.mastercardLogo,
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

  Widget _buildPriceResume({
    required String labelDescription,
    required String price,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            labelDescription,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text("\$$price"),
      ],
    );
  }
}
