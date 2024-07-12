import 'package:flutter/material.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/ui/core/components/order_list_item_widget.dart';

/// Definimos el ancho maximo de cada celda
const double _kCellWidth = 450.0;

/// Definimos el espaciado entre las celdas
const double _kCellSpacing = 16.0;

/// Widget para pintar los items de los pedidos en una lista desplazable.
class OrderListWidget extends StatefulWidget {
  final List<Order> orders;

  const OrderListWidget({
    super.key,
    required this.orders,
  });

  @override
  State<OrderListWidget> createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderListWidget> {
  final scrollController = ScrollController();
  List<Order> _orders = [];

  @override
  void initState() {
    _orders = widget.orders;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Se usa LayoutBuilder para obtener las dimensiones del widget padre
    return LayoutBuilder(
      builder: (context, constraints) {
        /// Calculamos el número de columnas que caben en el espacio disponible
        /// de la Grid.
        int columnCount = _calculateColumnCount(constraints.maxWidth);

        return GridView.builder(
          controller: scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            crossAxisSpacing: _kCellSpacing,
            mainAxisSpacing: columnCount == 1 ? 0 : _kCellSpacing,
            mainAxisExtent: 126,
          ),
          itemCount: _orders.length,
          itemBuilder: (context, index) {
            final order = _orders[index];
            return Column(
              children: [
                Flexible(child: OrderListItemWidget(order: order)),
                Divider(
                  height: 20,
                  thickness: 2,
                  indent: 16,
                  endIndent: 16,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
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
