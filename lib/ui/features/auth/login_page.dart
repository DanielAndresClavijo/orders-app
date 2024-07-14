import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/router/auth/auth_routes.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/core/components/auth/auth_access_button.dart';
import 'package:orders_app/ui/core/components/auth/auth_email_text_field.dart';
import 'package:orders_app/ui/core/components/auth/auth_pass_text_field.dart';
import 'package:orders_app/ui/core/components/buttons/interactive_text_button.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
    print("InitState LoginPage: $hashCode");
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(authNotifierProvider.notifier).restoreVariable();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLessThan360Width = context.screenSize.width < 360;
    print("LoginPage: $hashCode");
    return Scaffold(
      body: Center(
        child: Container(
          width: 480,
          padding: EdgeInsets.all(isLessThan360Width ? 16 : 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthEmailTextField(),
              const SizedBox(height: 16),
              const AuthPassTextField(),
              const SizedBox(height: 24),
              const AuthAccessButton(nameText: 'INICIAR SESION', isLogin: true),
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
