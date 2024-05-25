import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          const Text(
            'Username',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const Text(
            'azimjan@gmail.com',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 4, 40, 139)),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Row(
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
                ),),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
