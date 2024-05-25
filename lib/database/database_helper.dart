// lib/database/database_helper.dart
import 'package:path/path.dart';
import 'package:service_taxi/models/taxi_order.module.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'taxi_order.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE taxi_orders(id INTEGER PRIMARY KEY, phoneNumber TEXT, name TEXT, startLocation TEXT, finalLocation TEXT, comment TEXT, service TEXT, waitingTime TEXT, orderTime TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertOrder(TaxiOrder order) async {
    final db = await database;
    await db.insert('taxi_orders', order.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TaxiOrder>> orders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('taxi_orders');
    return List.generate(maps.length, (i) {
      return TaxiOrder.fromMap(maps[i]);
    });
  }

  Future<void> deleteOrder(int id) async {
    final db = await database;
    await db.delete('taxi_orders', where: 'id = ?', whereArgs: [id]);
  }
}
