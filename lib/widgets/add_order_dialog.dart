// lib/widgets/add_order_dialog.dart
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:service_taxi/models/taxi_order.module.dart';
import '../database/database_helper.dart';

class AddOrderDialog extends StatefulWidget {
  const AddOrderDialog({super.key});

  @override
  _AddOrderDialogState createState() => _AddOrderDialogState();
}

class _AddOrderDialogState extends State<AddOrderDialog> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _startLocationController = TextEditingController();
  final _finalLocationController = TextEditingController();
  final _commentController = TextEditingController();
  String _service = 'Standard';
  String _waitingTime = '10 minutes';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить заказ такси'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(prefix: Text('+7 '),
                  labelText: 'Номер телефона'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите номер телефона';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Имя'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите имя';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startLocationController,
                decoration: const InputDecoration(labelText: 'Начальное местоположение'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите место начала';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _finalLocationController,
                decoration: const InputDecoration(labelText: 'Окончательное местоположение'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите окончательное местоположение';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(labelText: 'Комментарий'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите комментарий';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _service,
                onChanged: (String? newValue) {
                  setState(() {
                    _service = newValue!;
                  });
                },
                items: <String>['Standard', 'Premium', 'VIP']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Service'),
              ),
              DropdownButtonFormField<String>(
                value: _waitingTime,
                onChanged: (String? newValue) {
                  setState(() {
                    _waitingTime = newValue!;
                  });
                },
                items: <String>['10 minutes', '20 minutes', '30 minutes']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Время ожидания'),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Отмена', style: TextStyle(color: Color.fromARGB(255, 255, 17, 0), fontWeight: FontWeight.bold),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Добавить', style: TextStyle(color: Color.fromARGB(255, 3, 195, 57), fontWeight: FontWeight.bold),),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final newOrder = TaxiOrder(
                phoneNumber: _phoneNumberController.text,
                name: _nameController.text,
                startLocation: _startLocationController.text,
                finalLocation: _finalLocationController.text,
                comment: _commentController.text,
                service: _service,
                waitingTime: _waitingTime,
                orderTime: DateTime.now(),
              );
              await DatabaseHelper().insertOrder(newOrder);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
