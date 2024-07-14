import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orders_app/injector/injector_providers.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';
import 'package:orders_app/ui/core/regex.dart';

class AuthPassTextField extends ConsumerWidget {
  const AuthPassTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pass = ref.watch(authNotifierProvider).pass;
    final loading = ref.watch(authNotifierProvider).loading;
    final isPassValid = pass == null ? true : _isPassValid(pass);
    return TextField(
      enabled: !loading,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color:
                isPassValid ? context.color.onSurface : context.color.onError,
          ),
        ),
        errorStyle: context.font.bodyMedium?.copyWith(
          color: context.color.onError,
        ),
        errorText: _getErrorText(isPassValid),
      ),
      onChanged: ref.watch(authNotifierProvider.notifier).onChangePassText,
    );
  }

  bool _isPassValid(String pass) {
    final isPassNotEmpty = pass.isNotEmpty;
    final isPassValid = passRegex.hasMatch(pass);
    return isPassNotEmpty && isPassValid;
  }

  String? _getErrorText(bool isEmailValid) {
    if (isEmailValid) return null;
    return "Contraseña incorrecta";
  }
}
