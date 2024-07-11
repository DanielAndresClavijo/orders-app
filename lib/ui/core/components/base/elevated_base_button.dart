import 'package:flutter/material.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

class ElevatedBaseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const ElevatedBaseButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        visualDensity: VisualDensity.comfortable,
        alignment: Alignment.center,
        // iconColor: WidgetStatePropertyAll(context.color.surface),
        foregroundColor: WidgetStatePropertyAll(
          context.color.surface,
        ),
        backgroundColor: WidgetStatePropertyAll(
          context.color.onSurface,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: child,
    );
  }
}
