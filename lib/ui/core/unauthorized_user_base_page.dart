import 'package:flutter/material.dart';
import 'package:orders_app/ui/core/button_theme.dart';

/// Layout base para las pantallas donde el usuario no este autenticado.
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
          child: ButtonThemeWidget(),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.fastfood),
            ),
            Flexible(
              child: Text(
                "Foddie",
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
