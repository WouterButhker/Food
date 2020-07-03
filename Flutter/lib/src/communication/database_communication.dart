

import 'dart:convert';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/user.dart';

class DatabaseCommunication {

  static Database _database;

  DatabaseCommunication();

  static Future<Database> getDatabase() async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  static Future reCreateDatabase() async {
    if (_database != null )await _database.close();
    await deleteDatabase(join(await getDatabasesPath(), 'database.db'));
    _database = null;
    print("Deleted database");
  }


  static Future<Database> initDatabase() async {

    Database database = await openDatabase(
      join(await getDatabasesPath(), 'database.db'),

      onCreate: _onDatabaseCreate,
      version: 3,
    );

    return database;
  }

   static Future<void> _onDatabaseCreate(Database db, int version) async {
    List<String> list = ["CREATE TABLE user_groups(id INTEGER PRIMARY KEY NOT NULL, name TEXT NOT NULL)",
     "CREATE TABLE users(id INTEGER PRIMARY KEY NOT NULL, name TEXT, email TEXT)",
    '''CREATE TABLE reservations(user_group INTEGER NOT NULL,
     user INTEGER NOT NULL, date TEXT NOT NULL, 
     amountEating INTEGER, amountCooking INTEGER, 
     FOREIGN KEY (user) REFERENCES users (id), 
     FOREIGN KEY (user_group) REFERENCES user_groups (id), 
     PRIMARY KEY (user_group, user, date))'''];

    Batch batch = db.batch();
    list.forEach((query) => batch.execute(query));

    return await batch.commit();
  }
  
  static Future<List<User>> getAllUsers() async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> list = await db.query("users");
    List<User> out = List<User>.from(list.map((item) => User.fromJson(item)));
    return out;
  }

  static Future<List<Group>> getAllGroupsFromUser() async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> list = await db.query('user_groups');
    List<Group> out = List<Group>.from(list.map((item) => Group.fromJson(item)));
    return out;
  }

  static Future addAllGroups(List<Group> groups) async {
    Database db = await getDatabase();
    for (Group group in groups) db.insert("user_groups", group.toJson());
  }







}