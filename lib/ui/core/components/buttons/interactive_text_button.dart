import 'package:flutter/material.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

/// Botón de texto interactivo.
class InteractiveTextButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;

  const InteractiveTextButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  State<InteractiveTextButton> createState() => _InteractiveTextButtonState();
}

class _InteractiveTextButtonState extends State<InteractiveTextButton> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      splashFactory: NoSplash.splashFactory,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHover: (isHover) {
        if (!isActive) {
          isActive = true;
          setState(() {});
        } else if (isActive) {
          isActive = false;
          setState(() {});
        }
      },
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Text(
          widget.text,
          style: context.font.bodyMedium?.copyWith(
            decoration: isActive ? TextDecoration.underline : null,
          ),
        ),
      ),
    );
  }
}
