import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student/src/communication/database_communication.dart';
import 'package:student/src/entities/database_item.dart';

@JsonSerializable()
class User extends DatabaseItem {
  String _email;
  String _name;
  String _password;

  User(this._email, this._name, this._password);

  User.fromJson(Map<String, dynamic> json)
      : _email = json['email'],
        _name = json['name'],
        _password = json['password'];

  static User getFromJson(Map<String, dynamic> json)  {
    return User.fromJson(json);
  }

  Map<String, dynamic> toJson() =>
      {'email': _email, 'name': _name, 'password': _password};

  Future<void> addToDatabase() async {
    return super.addToDatabaseByName("users");
  }

  String get email => _email;


}
