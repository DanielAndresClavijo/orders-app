import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/router/orders/orders_routes.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/core/components/base/elevated_base_button.dart';
import 'package:orders_app/ui/core/regex.dart';

class AuthAccessButton extends ConsumerWidget {
  final String nameText;
  final bool isLogin;

  const AuthAccessButton({
    super.key,
    required this.nameText,
    required this.isLogin,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(authNotifierProvider).email;
    final pass = ref.watch(authNotifierProvider).pass;
    final loading = ref.watch(authNotifierProvider).loading;
    final enabledButton =
        email != null && pass != null ? _enabledButton(email, pass) : false;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedBaseButton(
          onPressed: enabledButton && !loading
              ? () {
                  if (isLogin) {
                    ref
                        .read(authNotifierProvider.notifier)
                        .onLogin(email: email, password: pass)
                        .then(
                      (isAuthenticated) {
                        if (isAuthenticated) {
                          context.go(kOrdersListPath);
                        }
                      },
                    );
                  } else {
                    ref
                        .read(authNotifierProvider.notifier)
                        .onRegister(email: email, password: pass)
                        .then(
                      (isAuthenticated) {
                        if (isAuthenticated) {
                          context.go(kOrdersListPath);
                        }
                      },
                    );
                  }
                }
              : null,
          child: Text(nameText, textAlign: TextAlign.center),
        ),
        if (loading)
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: SizedBox.square(
              dimension: 32,
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }

  bool _enabledButton(String email, String pass) {
    final isEmailNotEmpty = email.isNotEmpty;
    final isPassNotEmpty = pass.isNotEmpty;
    final isEmailValid = emailRegex.hasMatch(email);
    final isPassValid = passRegex.hasMatch(pass);
    return isEmailNotEmpty && isPassNotEmpty && isEmailValid && isPassValid;
  }
}
