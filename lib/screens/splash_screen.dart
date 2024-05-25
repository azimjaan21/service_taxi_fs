
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:service_taxi/auth/services/auth.service.dart';
import 'package:service_taxi/auth/sign_up_screen.dart';
import 'package:service_taxi/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashIconSize: 200,
        backgroundColor: Colors.yellow,
        splash: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Image.asset(
            'assets/logo.png',
          ),
        ),
        nextScreen:  AuthService.auth.currentUser == null
            ? SignUpScreen()
            : const HomeScreen(),
      ),
    );
  }
}

