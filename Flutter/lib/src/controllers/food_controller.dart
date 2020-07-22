import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student/src/communication/database_communication.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/entities/user.dart';
import 'package:student/src/models/language_model.dart';

class FoodController {
  static void yes(DateTime date, Group group) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"), amountEating: 1);
    ServerCommunication.sendReservation(res);
  }

  static void no(DateTime date, Group group) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"), amountEating: 0);
    ServerCommunication.sendReservation(res);
  }

  static void cook(DateTime date, Group group) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"), amountEating: 1, isCooking: true);
    ServerCommunication.sendReservation(res);
  }

  static void maybe(DateTime date, Group group) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"));
    ServerCommunication.deleteReservation(res);
  }

  static void custom(DateTime date, Group group, {int amountEating: 1, bool isCooking: false}) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"), amountEating: amountEating, isCooking: isCooking);
    ServerCommunication.sendReservation(res);
  }

  static Future<List<Reservation>> getAllReservations(int groupId) async {
    Response res = await ServerCommunication.getAllReservations(groupId);
    Iterable i = json.decode(res.body);
    return List<Reservation>.from(i.map((val) => Reservation.fromJson(val)));
  }

  static Future<List<User>> getUsersInGroup(int groupId) async {
    Response res = await ServerCommunication.getUsersInGroup(groupId);
    Iterable i = json.decode(res.body);
    return List<User>.from(i.map((val) => User.fromJson(val)));
  }

}
