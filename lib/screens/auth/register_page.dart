import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers for managing text field values
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add a Scaffold for basic app structure
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Padding(
          // Add padding for better visual spacing
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(
                  height: 24), // Increased spacing for better visual separation
              ElevatedButton(
                onPressed: () {
                  // Access email and password values using controllers
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  // Perform registration logic here
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
