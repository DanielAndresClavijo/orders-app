import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/assets.dart';
import 'package:orders_app/config/router/auth/auth_routes.dart';
import 'package:orders_app/ui/core/components/base/elevated_base_button.dart';
import 'package:orders_app/ui/core/extensions/context_extension.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /// Tiene menos de 360 de ancho
    final isLessThan360Width = context.screenSize.width < 360;
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: Stack(
              children: [
                Image.asset(
                  Assets.banner,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
                Positioned(
                  top: -5,
                  left: 0,
                  right: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: context.theme.scaffoldBackgroundColor,
                          blurRadius: 10,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const SizedBox(height: 16),
                  ),
                ),
                Positioned(
                  bottom: -6,
                  left: 0,
                  right: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: context.theme.scaffoldBackgroundColor,
                          blurRadius: 10,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const SizedBox(height: 16),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: isLessThan360Width ? 2 : 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                0,
                25,
                8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      "Descubre los platillos más sabrosos y experiencias culinarias únicas. Regístrate y únete a nuestra comunidad de foodies. ¡Tu próximo manjar te espera!",
                      style: isLessThan360Width
                          ? context.font.bodyLarge
                          : context.font.headlineSmall,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedBaseButton(
                    onPressed: () {
                      context.go(kLoginPath);
                    },
                    child: const Text("SABER MAS"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
