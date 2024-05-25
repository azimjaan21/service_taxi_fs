// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:service_taxi/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBSbsBDP4CeWe2z0yeWHBy9_puz8jHb_PQ",
          authDomain: "servicetaxi-27fb1.firebaseapp.com",
          projectId: "servicetaxi-27fb1",
          storageBucket: "servicetaxi-27fb1.appspot.com",
          messagingSenderId: "956242210472",
          appId: "1:956242210472:web:4a099a9289e666be55dc9d",
          measurementId: "G-RQGFF41HLT"),
    );
  } else {
    Firebase.initializeApp();
  }

  runApp(const ServiceTaxi());
}

class ServiceTaxi extends StatelessWidget {
  const ServiceTaxi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Order App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
