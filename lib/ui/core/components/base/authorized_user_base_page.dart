import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/router/welcome/welcome_routes.dart';
import 'package:orders_app/ui/core/components/buttons/back_button.dart';
import 'package:orders_app/ui/core/components/buttons/menu_wrapper_button.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

/// Origen de la página del pedido
enum OrderPageOrigin { list, history, detail }

/// Layout base para las pantallas donde el usuario este autenticado.
///
/// Ejemplo de pantallas donde el usuario esta autenticado, son:
///  - OrderList
///  - OrderHistory
///  - OrderDetails
class AuthorizedBasePage extends StatelessWidget {
  final Widget child;

  const AuthorizedBasePage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: BackButtonWidget(
            onBack: () {
              context.go(kHomePath);
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
            child: MenuWrapperButtonWidget(onWrap: () {}),
          ),
        ],
        title: Center(
          child: Text(
            "Historial",
            style: context.font.headlineMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: child,
    );
  }
}
