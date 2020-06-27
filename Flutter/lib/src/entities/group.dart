

import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:student/src/communication/database_communication.dart';
import 'package:student/src/entities/database_item.dart';

class Group extends DatabaseItem {

  String _name;
  int _id;

  Group(this._id, this._name);
  Group.onlyName(this._name);

  Group.fromJson(Map<String, dynamic> json)
  : _id = json["id"],
  _name = json["name"];

  static Group getFromJson(Map<String, dynamic> json) {
    return Group.fromJson(json);
  }

  static List<Group> getListFromJson(String jsonString) {
    Iterable jsonResponse = json.decode(jsonString);
    return List<Group>.from(jsonResponse.map((e) => Group.fromJson(e)));
  }

  Map<String, dynamic> toJson() => {
    'id' : _id,
    'name' : _name
  };

  Future addToDatabase() async {
    return super.addToDatabaseByName("user_groups");
  }

  @override
  String toString() {
    return 'Group{_name: $_name, _id: $_id}';
  }

  int get id => _id;
  String get name => _name;
}