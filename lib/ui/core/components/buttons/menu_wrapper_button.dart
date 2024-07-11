import 'package:flutter/material.dart';
import 'package:orders_app/ui/core/components/base/icon_base_button.dart';

class MenuWrapperButtonWidget extends StatelessWidget {
  final VoidCallback onWrap;

  const MenuWrapperButtonWidget({
    super.key,
    required this.onWrap,
  });

  @override
  Widget build(BuildContext context) {
    return IconBaseButton(
      onPressed: onWrap,
      toggleColor: true,
      icon: const Icon(Icons.menu),
    );
  }
}
