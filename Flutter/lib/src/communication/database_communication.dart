

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
    String groups = "CREATE TABLE user_groups(id INTEGER PRIMARY KEY NOT NULL, name TEXT NOT NULL)";
    String users = "CREATE TABLE users(id INTEGER PRIMARY KEY NOT NULL, name TEXT, email TEXT)";
    String reservation = '''CREATE TABLE reservations(user_group INTEGER NOT NULL,
     user INTEGER NOT NULL, date TEXT NOT NULL, 
     amountEating INTEGER, amountCooking INTEGER, 
     FOREIGN KEY (user) REFERENCES users (id), 
     FOREIGN KEY (user_group) REFERENCES user_groups (id), 
     PRIMARY KEY (user_group, user, date))''';
    List<String> list = [groups, users, reservation];

    Batch batch = db.batch();
    list.forEach((query) => batch.execute(query));

    return await batch.commit();
  }
  
  static Future<List<User>> getAllUsers() async {
//    Database db = await getDatabase();
//    List<Map<String, dynamic>> list = await db.query("users");
//    List<User> out;
//    list.map((user) => out.add(User.fromJson(user)));
//    return out;

  List list = await getAllFromDatabase("users", User.getFromJson);
  return List<User>.from(list);
  }

  static Future<List<Group>> getAllGroupsFromUser() async {
//    Database db = await getDatabase();
//    List<Map<String, dynamic>> list = await db.query('groups');
//    List<Group> out = List<Group>.from(list.map((item) => Group.fromJson(item)));
//    return out;
    List<dynamic> list = await getAllFromDatabase('user_groups', Group.getFromJson);
    List<Group> groups = List<Group>.from(list);
    return groups;
  }

  static Future<List> getAllFromDatabase(String table, Function(Map<String, dynamic>) constructor) async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> list = await db.query(table);
    List out = List.from(list.map((item) => constructor(item)));
    return out;
  }






}