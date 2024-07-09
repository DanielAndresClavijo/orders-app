import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_app/config/router/auth_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              context.go(kLoginPath);
            },
            child: Text("Ir al login"),
          )
        ],
      ),
    );
  }
}
