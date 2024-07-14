import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';
import 'package:orders_app/ui/core/regex.dart';

class AuthEmailTextField extends ConsumerWidget {
  const AuthEmailTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(authNotifierProvider).email;
    final isEmailValid = email == null ? true : _isEmailValid(email);
    final loading = ref.watch(authNotifierProvider).loading;
    return TextField(
      enabled: !loading,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color:
                isEmailValid ? context.color.onSurface : context.color.onError,
          ),
        ),
        errorStyle: context.font.bodyMedium?.copyWith(
          color: context.color.onError,
        ),
        errorText: _getErrorText(isEmailValid),
      ),
      onChanged: ref.watch(authNotifierProvider.notifier).onChangeEmailText,
    );
  }

  bool _isEmailValid(String email) {
    final isEmailNotEmpty = email.isNotEmpty;
    final isEmailValid = emailRegex.hasMatch(email);
    return isEmailNotEmpty && isEmailValid;
  }

  String? _getErrorText(bool isEmailValid) {
    if (isEmailValid) return null;
    return "Email incorrecto";
  }
}
