import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

// Definimos el ancho mínimo de cada celda
const double _kCellWidth = 300.0;

// Definimos el espaciado entre las celdas
const double _kCellSpacing = 16.0;

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
    // Usamos LayoutBuilder para obtener las dimensiones del widget padre
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculamos el número de columnas que caben en el espacio disponible
        int columnCount = _calculateColumnCount(constraints.maxWidth);

        return GridView.builder(
          controller: scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            crossAxisSpacing: _kCellSpacing,
            mainAxisSpacing: columnCount == 1 ? 0 : _kCellSpacing,
            mainAxisExtent: 102,
          ),

          // Número de ítems en el GridView
          itemCount: _orders.length,
          itemBuilder: (context, index) {
            final order = _orders[index];
            return Container(
              // color: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 56,
                      height: 56,
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        order.name,
                        style: context.font.titleMedium,
                      ),
                      Text(
                        "${order.products.length} artículos",
                        style: context.font.labelSmall,
                      ),
                      Text(
                        order.name,
                        style: context.font.labelSmall,
                      ),
                      Text(
                        DateFormat("mm dd").format(order.createdAt),
                        style: context.font.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
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
