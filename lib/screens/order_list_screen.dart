// lib/screens/order_list_screen.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_taxi/models/taxi_order.module.dart';
import 'dart:async';
import '../database/database_helper.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late Future<List<TaxiOrder>> futureOrders;

  @override
  void initState() {
    super.initState();
    _refreshOrders();
  }

  void _refreshOrders() {
    setState(() {
      futureOrders = DatabaseHelper().orders();
    });
  }

  Duration parseWaitingTime(String waitingTime) {
    switch (waitingTime) {
      case '10 minutes':
        return const Duration(minutes: 10);
      case '20 minutes':
        return const Duration(minutes: 20);
      case '30 minutes':
        return const Duration(minutes: 30);
      default:
        return const Duration(minutes: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Заказать список такси'),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: FutureBuilder<List<TaxiOrder>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Заказов не найдено.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                final remainingTime =
                    parseWaitingTime(order.waitingTime).inSeconds -
                        DateTime.now().difference(order.orderTime).inSeconds;
                return OrderTile(
                  order: order,
                  initialRemainingTime: remainingTime,
                  onDelete: () async {
                    await DatabaseHelper().deleteOrder(order.id!);
                    _refreshOrders();
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
class OrderTile extends StatefulWidget {
  final TaxiOrder order;
  final int initialRemainingTime;
  final VoidCallback onDelete;

  const OrderTile({
    super.key,
    required this.order,
    required this.initialRemainingTime,
    required this.onDelete,
  });

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  late int remainingTime;
  late Timer timer;
  bool taxiHere = false;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.initialRemainingTime;
    if (remainingTime > 0) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (remainingTime > 0) {
            remainingTime--;
          } else {
            taxiHere = true;
            timer.cancel();
          }
        });
      });
    } else {
      taxiHere = true;
    }
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (remainingTime / 60).floor();
    final seconds = remainingTime % 60;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        child: ListTile(
          leading: const Icon(
            CupertinoIcons.car_detailed,
            color: Colors.black,
            size: 30,
          ),
         title: Padding(
           padding: const EdgeInsets.symmetric(vertical: 8.0),
           child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      // Use Expanded to allow text to take available space
                      child: Text(
                        '${widget.order.startLocation} — ${widget.order.finalLocation}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis, // Ensure text does not overflow
                        ),
                      ),
                    ),
                  ],
                ),
         ),
              
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 20,
                     color: Colors.amber,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Service: ${widget.order.service}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 7, 3, 97),
                      overflow: TextOverflow.ellipsis, // Ensure text does not overflow
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (taxiHere)
                const Text(
                  'Такси здесь!',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                )
              else
                Row(
                  children: [
                    const Icon(
                      Icons.alarm,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Время ожидания: $minutes:${seconds.toString().padLeft(2, '0')}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.cancel_outlined, color: Colors.red),
            onPressed: widget.onDelete,
          ),
        ),
      ),
    );
  }
}
