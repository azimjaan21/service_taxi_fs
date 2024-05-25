// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:service_taxi/screens/profile_screen.dart';
import '../widgets/add_order_dialog.dart';
import 'order_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        shape: RoundedRectangleBorder(),
        backgroundColor: Color.fromARGB(255, 223, 223, 223),
        child: ProfileScreen(),
      ),
      appBar: AppBar(
        title: const Text('Service Taxi'),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/map1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54,
              ),
            ],
          ),

          // Centered button
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, iconColor: Colors.white),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.car_crash_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Заказ такси',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AddOrderDialog();
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.yellow,
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.list,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrderListScreen()),
          );
        },
      ),
    );
  }
}
