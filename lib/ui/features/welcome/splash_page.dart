import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:orders_app/config/assets.dart';
import 'package:orders_app/config/router/orders/orders_routes.dart';
import 'package:orders_app/config/router/welcome/welcome_routes.dart';
import 'package:orders_app/injector/injector_providers.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1500), () {
      final isUserInSession =
          ref.read(authNotifierProvider.notifier).checkUserSession();
      if (isUserInSession) {
        context.go(kOrdersListPath);
        return;
      }

      context.go(kHomePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                Assets.splashAnimation,
                // Replace with the path to your Lottie JSON file
                fit: BoxFit.cover,
                width: 400, // Adjust the width and height as needed
                height: 400,
                repeat: true, // Set to true if you want the animation to loop
              ),
            ),
            const Center(
              child: Text(
                "Cocinando...",
              ),
            )
          ],
        ),
      ),
    );
  }
}