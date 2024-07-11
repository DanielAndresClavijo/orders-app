import 'package:flutter/material.dart';
import 'package:orders_app/ui/core/components/base/icon_base_button.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback onBack;

  const BackButtonWidget({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return IconBaseButton(
      onPressed: onBack,
      icon: const Icon(Icons.arrow_back),
    );
  }
}
