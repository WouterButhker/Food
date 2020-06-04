import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student/src/communication/database_communication.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/entities/user.dart';
import 'package:student/src/models/language_model.dart';

class FoodController {
  static void yes() {
    Reservation _res =
        Reservation("Samballen", DateTime.now(), 1, amountEating: 1);
    String _json = jsonEncode(_res);
    print(_json);
    ServerCommunication.sendReservation(_res).then((val) {
      print(val.statusCode);
    });
  }

  static void no() {
    User user = new User("p@inda", "Pinda", "pass");
    ServerCommunication.register(user).then((res) {
      if (res.statusCode == 200) {
      } else if (res.statusCode == 403) {
        print("Not authorized");
      } else {
       // Map<String, dynamic> json = jsonDecode(res.body);
        print("Error " + res.statusCode.toString()); //+ ": " + json["message"]);
      }
    });
//            DatabaseCommunication.initDatabase().then((db) {
//              db.query("users").then((val) {
//                print(val);
//              });
//            });

//            user.addToDatabase();
//            DatabaseCommunication.getAllUsers().then((val) {
//              print(val);
//              print("all users printed");
//            }).catchError((err) => print(err));
  }

  static void cook() async {
    Response res = await ServerCommunication.addGroup("BIERR");
    Map<String, dynamic> json = jsonDecode(res.body);
    Group group = new Group.fromJson(json);
    print(group);
    group.addToDatabase();

    List<Group> groups = await DatabaseCommunication.getAllGroupsFromUser();
    int id = groups.elementAt(0).id;
    var response = await ServerCommunication.getUsersFromGroup(id);

    print(groups);

    print("all users (in group 0) " + response.body.toString());
    List<User> users = await DatabaseCommunication.getAllUsers();
    print(users);
  }

  static void maybe() {
    ServerCommunication.getAllReservations(1);
  }

  static void custom(int amountEating, int amountCooking) {
    //DatabaseCommunication.reCreateDatabase();
    //ServerCommunication.authenticatedGet("/mail");

  }
}
