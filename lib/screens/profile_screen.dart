// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_taxi/auth/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('No user is currently signed in.'));
    }

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.black,
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            user.displayName ?? 'Username',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            user.email ?? 'email@example.com',
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 4, 40, 139)),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Выйти',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
