import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  final VoidCallback onBack;

  const ButtonBack({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onBack,
      style: ButtonStyle(
        visualDensity: VisualDensity.comfortable,
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        alignment: Alignment.center,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: const Icon(Icons.arrow_back),
    );
  }
}
