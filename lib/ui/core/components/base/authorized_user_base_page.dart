import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/navigation_history.dart';
import 'package:orders_app/ui/core/components/base/side_drawer_menu.dart';
import 'package:orders_app/ui/core/components/buttons/back_button.dart';
import 'package:orders_app/ui/core/components/buttons/menu_wrapper_button.dart';
import 'package:orders_app/ui/core/constants_app.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

/// Layout base para las pantallas donde el usuario este autenticado.
///
/// Ejemplo de pantallas donde el usuario esta autenticado, son:
///  - OrderList
///  - OrderHistory
///  - OrderDetails
class AuthorizedBasePage extends StatelessWidget {
  final NavigationHistory navigationHistory;
  final Widget child;

  const AuthorizedBasePage({
    super.key,
    required this.navigationHistory,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leadingWidth: 0,
        surfaceTintColor: Colors.transparent,
        actions: const [SizedBox(width: 0, height: 8)],
        titleSpacing: 16,
        title: Center(
          child: SizedBox(
            width: kWidthPage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: BackButtonWidget(
                    onBack: () {
                      context.go(navigationHistory.popPath);
                    },
                  ),
                ),
                Text(
                  "Historial",
                  style: context.font.headlineMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: MenuWrapperButtonWidget(onWrap: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: const SideDrawerMenu(),
      body: child,
    );
  }
}
