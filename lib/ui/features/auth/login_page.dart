import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/router/auth/auth_routes.dart';
import 'package:orders_app/config/router/orders/orders_routes.dart';
import 'package:orders_app/ui/core/components/base/elevated_base_button.dart';
import 'package:orders_app/ui/core/components/buttons/interactive_text_button.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLessThan360Width = context.screenSize.width < 360;
    return Scaffold(
      body: Center(
        child: Container(
          width: 480,
          padding: EdgeInsets.all(isLessThan360Width ? 16 : 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedBaseButton(
                onPressed: () {
                  context.go(kOrdersListPath);
                },
                child: const Text(
                  'INICIAR SESION',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              InteractiveTextButton(
                onTap: () {
                  context.go(kRegisterPath);
                },
                text: "Registrarse",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
