import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/app_view_model.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

/// Widget que configura las notificaciones para mostrar mensajes flotantes en
/// la app.
class NotificationWrapperBasePage extends ConsumerWidget {
  final Widget child;

  const NotificationWrapperBasePage({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    setupSnackBar(ref);
    return child;
  }

  void setupSnackBar(WidgetRef ref) {
    final notification = ref.watch(appNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (notification != null) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(
            content: Text(notification.message),
            backgroundColor: _getBackgroundColor(
              ref.context,
              notification.type,
            ),
          ),
        );

        ref.read(appNotifierProvider.notifier).clear();
      }
    });
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
