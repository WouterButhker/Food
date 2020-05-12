import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class User {
  String _email;
  String _name;
  String _password;
  
  User(this._email, this._name, this._password);

  User.fromJson(Map<String, dynamic> json)
  : _email = json['email'],
  _name = json['name'],
  _password = json['password'];

  Map<String, dynamic> toJson() => {
    'email' : _email,
    'name' : _name,
    'password' : _password
  };

}