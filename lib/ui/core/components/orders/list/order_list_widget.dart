import 'package:flutter/material.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/ui/core/components/orders/list/order_list_item_widget.dart';

/// Definimos el ancho maximo de cada celda
const double _kCellWidth = 450.0;

/// Definimos el espaciado entre las celdas
const double _kCellSpacing = 16.0;

/// Widget para pintar los items de los pedidos en una lista desplazable.
class OrderListWidget extends StatelessWidget {
  final List<Order> orders;
  final String Function(String imageUrl) getImageUrl;

  const OrderListWidget({
    super.key,
    required this.orders,
    required this.getImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    /// Se usa LayoutBuilder para obtener las dimensiones del widget padre
    return LayoutBuilder(
      builder: (context, constraints) {
        /// Calculamos el número de columnas que caben en el espacio disponible
        /// de la Grid.
        int columnCount = _calculateColumnCount(constraints.maxWidth);

        return GridView.builder(
          controller: ScrollController(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            crossAxisSpacing: _kCellSpacing,
            mainAxisSpacing: 0,
            mainAxisExtent: 126,
          ),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return OrderListItemWidget(
              order: order,
              imageUrl: getImageUrl(order.imageId ?? ""),
            );
          },
        );
      },
    );
  }

  int _calculateColumnCount(double screenWidth) {
    final double width = screenWidth + _kCellSpacing;
    const double defaultWidth = _kCellWidth + _kCellSpacing;
    if (width < defaultWidth) return 1;
    return (width / defaultWidth).floor();
  }
}