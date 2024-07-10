import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/config/theme.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

class ButtonThemeWidget extends ConsumerWidget {
  const ButtonThemeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    return ElevatedButton(
      onPressed: () {
        ref.read(themeNotifierProvider).toggleTheme();
      },
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
      child: Icon(
        isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: context.color.onSurface,
      ),
    );
  }
}
