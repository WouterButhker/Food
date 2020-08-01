import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student/src/communication/database_communication.dart';
import 'package:student/src/entities/database_item.dart';

@JsonSerializable()
class User extends DatabaseItem implements Comparable<User> {
  String _email;
  String _name;
  String _password;
  int _id;

  User(this._id, this._email, this._name, this._password);

  User.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _email = json['email'],
        _name = json['name'],
        _password = json['password'];

  static User getFromJson(Map<String, dynamic> json)  {
    return User.fromJson(json);
  }

  Map<String, dynamic> toJson() =>
      {'id': _id, 'email': _email, 'name': _name, 'password': _password};

  Future<void> addToDatabase() async {
    return await super.addToDatabaseByName("users");
  }

  String get email => _email;
  int get id => _id;
  String get name => _name;

  @override
  String toString() {
    return 'User{_email: $_email, _name: $_name, _password: $_password}';
  }

  @override
  int compareTo(User other) {
    return name.toLowerCase().compareTo(other.name.toLowerCase());
  }
}
