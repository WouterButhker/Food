import 'package:sqflite/sqflite.dart';
import 'package:student/src/communication/database_communication.dart';

abstract class DatabaseItem {

  DatabaseItem();

  DatabaseItem.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  Future addToDatabase();

  Future<void> addToDatabaseByName(String tableName) async {
    final Database db = await DatabaseCommunication.getDatabase();
    await db.insert(tableName, toJson());
  }

  String toString();
}