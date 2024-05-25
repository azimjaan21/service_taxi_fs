// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_taxi/auth/services/auth.service.dart';
import 'package:service_taxi/screens/home_screen.dart';
import 'package:service_taxi/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(controller: _emailController, hintText: 'Email'),
            const SizedBox(height: 16),
            CustomTextField(controller: _passwordController, hintText: 'Password', isPassword: true),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                if (email.isNotEmpty && password.isNotEmpty) {
                  User? user = await AuthService().signUpWithEmail(email, password);
                  if (user != null) {
                    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (Route<dynamic> route) => false,
    );
                  } else {
                    // Show error
                  }
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
