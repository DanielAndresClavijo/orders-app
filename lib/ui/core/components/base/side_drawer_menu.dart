import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/router/welcome/welcome_routes.dart';
import 'package:orders_app/domain/entities/order.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/features/orders/order_view_model.dart';

class SideDrawerMenu extends ConsumerWidget {
  const SideDrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(orderListNotifierProvider).currentPageFilter;
    final selectedStatus = ref.watch(orderListNotifierProvider).statusFilter;
    final totalPage = ref.watch(orderListNotifierProvider).totalPage;
    final pageSize = ref.watch(orderListNotifierProvider).pageSizeFilter;
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            ref.read(authNotifierProvider.notifier).getUserEmail() ??
                "Hola usuario.",
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Filtrar por estado'),
            trailing: DropdownButton<OrderStatus>(
              borderRadius: BorderRadius.circular(8),
              padding: const EdgeInsets.only(left: 8),
              value: selectedStatus,
              hint: Text("Sin elegir"),
              onChanged: (OrderStatus? newValue) {
                ref
                    .read(orderListNotifierProvider.notifier)
                    .filterByStatus(newValue);
              },
              items: OrderStatus.values
                  .map<DropdownMenuItem<OrderStatus>>((OrderStatus value) {
                return DropdownMenuItem<OrderStatus>(
                  value: value,
                  child: Text(value.text),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Tamaño de paginación'),
            trailing: DropdownButton<int>(
              value: pageSize,
              borderRadius: BorderRadius.circular(8),
              padding: const EdgeInsets.only(left: 8),
              onChanged: (int? newValue) {
                if (newValue == null) return;
                ref
                    .read(orderListNotifierProvider.notifier)
                    .filterBySizePage(newValue);
              },
              items: kPageSize.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Número de paginación'),
            trailing: DropdownButton<int>(
              value: currentPage,
              borderRadius: BorderRadius.circular(8),
              padding: const EdgeInsets.only(left: 8),
              onChanged: (int? newValue) {
                if (newValue == null) return;
                ref
                    .read(orderListNotifierProvider.notifier)
                    .filterByPageNumber(newValue);
              },
              items: List<int>.generate(totalPage, (i) => i + 1)
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          ),
          const Spacer(),
          ListTile(
            title: const Text('Cerrar Sesion'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () async {
              ref.read(authNotifierProvider.notifier).onLogOut();
              context.go(kHomePath);
            },
          ),
        ],
      ),
    );
  }
}
