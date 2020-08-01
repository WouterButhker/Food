import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student/src/communication/database_communication.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/entities/user.dart';
import 'package:student/src/models/language_model.dart';
import 'package:student/src/widgets/food_screen/models/reservations_model.dart';
import 'package:student/src/widgets/food_screen/models/reservations_model.dart';
import 'package:student/src/widgets/food_screen/models/reservations_model.dart';
import 'package:student/src/widgets/food_screen/models/reservations_model.dart';

class FoodController {
  static void yes(DateTime date, Group group, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"), amountEating: 1, isCooking: false);
    Response response = await ServerCommunication.sendReservation(res);

    if (response.statusCode == 200) Provider.of<ReservationModel>(context, listen: false).addReservation(res);
  }

  static void no(DateTime date, Group group, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"), amountEating: 0, isCooking: false);
    Response response = await ServerCommunication.sendReservation(res);

    if (response.statusCode == 200) Provider.of<ReservationModel>(context, listen: false).addReservation(res);
  }

  static void cook(DateTime date, Group group, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"), amountEating: 1, isCooking: true);
    Response response = await ServerCommunication.sendReservation(res);

    if (response.statusCode == 200) Provider.of<ReservationModel>(context, listen: false).addReservation(res);
  }

  static void maybe(DateTime date, Group group, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"));
    Response response = await ServerCommunication.deleteReservation(res);

    if (response.statusCode == 200) Provider.of<ReservationModel>(context, listen: false).deleteReservation(date, prefs.getInt("userId"), group.id);
  }

  static void custom(DateTime date, Group group, BuildContext context, {int amountEating: 1, bool isCooking: false, int userId}) async {

    if (userId == null) {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getInt("userId");
    } else {
      // TODO verify user is correct
    }

    Reservation res = Reservation(group.id, date, userId, amountEating: amountEating, isCooking: isCooking);
    Response response = await ServerCommunication.sendReservation(res);

    if (response.statusCode == 200) Provider.of<ReservationModel>(context, listen: false).addReservation(res);
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
