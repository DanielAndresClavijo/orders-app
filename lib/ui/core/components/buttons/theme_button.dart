import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/core/components/base/icon_base_button.dart';

class ThemeButtonWidget extends ConsumerWidget {
  const ThemeButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    return IconBaseButton(
      onPressed: () {
        ref.read(themeNotifierProvider).toggleTheme();
      },
      icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
    );
  }
}
