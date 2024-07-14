import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/app_view_model.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

/// Widget base que envuelve toda la app.
class AppWrapper extends ConsumerWidget {
  final Widget child;

  const AppWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _setupSnackBar(ref);
    return child;
  }

  /// Configura la snack-bar para las notificaciones de la app.
  void _setupSnackBar(WidgetRef ref) {
    final notification = ref.watch(appProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (notification != null) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(
            content: Text(
              notification.message,
              style: ref.context.font.bodyMedium?.copyWith(
                color: _getTextColor(
                  ref.context,
                  notification.type,
                ),
              ),
            ),
            backgroundColor: _getBackgroundColor(
              ref.context,
              notification.type,
            ),
          ),
        );

        ref.read(appProvider.notifier).clear();
      }
    });
  }

  Color _getTextColor(BuildContext context, NotificationType type) {
    switch (type) {
      case NotificationType.error:
        return context.color.onError;
      case NotificationType.alert:
        return context.color.onSecondaryContainer;
      case NotificationType.info:
      default:
        return context.color.onSecondary;
    }
  }

  Color _getBackgroundColor(BuildContext context, NotificationType type) {
    switch (type) {
      case NotificationType.error:
        return context.color.error;
      case NotificationType.alert:
        return context.color.surfaceTint;
      case NotificationType.info:
      default:
        return context.color.secondary;
    }
  }
}
