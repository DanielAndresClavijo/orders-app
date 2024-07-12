import 'package:flutter/material.dart';
import 'package:orders_app/ui/core/components/buttons/theme_button.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

/// Layout base para las pantallas donde el usuario no este autenticado.
///
/// Ejemplo de pantallas donde el usuario no esta autenticado, son:
///  - HomePage
///  - LoginPage
///  - RegisterPage
class UnauthorizedBasePage extends StatelessWidget {
  final Widget child;

  const UnauthorizedBasePage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56,
        leading: const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: ThemeButtonWidget(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.fastfood),
            ),
            Flexible(
              child: Text(
                "Foddie",
                style: context.font.headlineMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
