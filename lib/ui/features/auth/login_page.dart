import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/router/auth/auth_routes.dart';
import 'package:orders_app/config/router/orders/orders_routes.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';
import 'package:orders_app/ui/core/interactive_text_button.dart';

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
              ElevatedButton(
                onPressed: () {
                  context.go(kOrdersListPath);
                },
                style: ButtonStyle(
                  visualDensity: VisualDensity.comfortable,
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 16),
                  ),
                  alignment: Alignment.center,
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: Text(
                  'INICIAR SESION',
                  style: context.font.titleMedium?.copyWith(
                    color: context.color.onSurface,
                  ),
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
