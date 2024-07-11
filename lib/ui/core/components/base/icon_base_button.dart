import 'package:flutter/material.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

/// Boton de icono base.
///
/// [toggleColor] Alterna el color de fondo por el colo de icono y en viceversa.
class IconBaseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final bool toggleColor;

  const IconBaseButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.toggleColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: ButtonStyle(
        visualDensity: VisualDensity.comfortable,
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        alignment: Alignment.center,
        iconColor: WidgetStatePropertyAll(
          toggleColor ? context.color.onSurface : context.color.surface,
        ),
        backgroundColor: WidgetStatePropertyAll(
            toggleColor ? context.color.surface : context.color.onSurface),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      icon: icon,
    );
  }
}
