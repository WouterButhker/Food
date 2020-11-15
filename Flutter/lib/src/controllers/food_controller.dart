import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/network_exception.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/entities/user.dart';
import 'package:student/src/widgets/food_screen/models/reservations_model.dart';

// TODO refactor duplicate code
class FoodController {
  static void yes(DateTime date, Group group, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"),
        amountEating: 1, isCooking: false);

    // TODO refactor this loading snackbar
    bool responseCompleted = false;

    Future<Response> response;
    Reservation deleted = Provider.of<ReservationModel>(context, listen: false)
        .addReservation(res);

    try {
      response =
      ServerCommunication.sendReservation(res).whenComplete(() {
        responseCompleted = true;
        Scaffold.of(context).hideCurrentSnackBar();
      });
    } on NetworkException catch (e) {
      e.showErrorSnackbar(context);
      if (deleted == null) {
        // delete new reservation
        Provider.of<ReservationModel>(context, listen: false)
            .deleteReservation(date, prefs.getInt("userId"), group.id);
      } else {
        // re-add deleted reservation, also deletes new reservation
        Provider.of<ReservationModel>(context, listen: false)
            .addReservation(deleted);
      }
    }

    // if response takes longer than 1 second show loading icon
    // TODO: have a minimum time for the loading snackbar
    Future<void> delay = Future.delayed(Duration(seconds: 1));

    delay.whenComplete(() {
      if (!responseCompleted) {
        SnackBar loadingSnack = SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularProgressIndicator(),
              Text("Making your reservation..."),
            ],
          ),
        );

        Scaffold.of(context).showSnackBar(loadingSnack);
      }
    });


  }

  static void no(DateTime date, Group group, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"),
        amountEating: 0, isCooking: false);
    Future<Response> response;
    Reservation deleted = Provider.of<ReservationModel>(context, listen: false)
        .addReservation(res);

    try {
      response = ServerCommunication.sendReservation(res);
    } on NetworkException catch (e) {
      e.showErrorSnackbar(context);
      if (deleted == null) {
        // delete new reservation
        Provider.of<ReservationModel>(context, listen: false)
            .deleteReservation(date, prefs.getInt("userId"), group.id);
      } else {
        // re-add deleted reservation, also deletes new reservation
        Provider.of<ReservationModel>(context, listen: false)
            .addReservation(deleted);
      }
    }
  }

  static void cook(DateTime date, Group group, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"),
        amountEating: 1, isCooking: true);
    Future<Response> response;
    Reservation deleted = Provider.of<ReservationModel>(context, listen: false)
        .addReservation(res);

    try {
      response = ServerCommunication.sendReservation(res);
    } on NetworkException catch (e) {
      e.showErrorSnackbar(context);
      if (deleted == null) {
        // delete new reservation
        Provider.of<ReservationModel>(context, listen: false)
            .deleteReservation(date, prefs.getInt("userId"), group.id);
      } else {
        // re-add deleted reservation, also deletes new reservation
        Provider.of<ReservationModel>(context, listen: false)
            .addReservation(deleted);
      }
    }
  }

  static void maybe(DateTime date, Group group, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    Reservation res = Reservation(group.id, date, prefs.getInt("userId"));
    Future<Response> response;
    Reservation deleted = Provider.of<ReservationModel>(context, listen: false)
        .addReservation(res);

    try {
      response = ServerCommunication.deleteReservation(res);
    } on NetworkException catch (e) {
      e.showErrorSnackbar(context);
      if (deleted == null) {
        // delete new reservation
        Provider.of<ReservationModel>(context, listen: false)
            .deleteReservation(date, prefs.getInt("userId"), group.id);
      } else {
        // re-add deleted reservation, also deletes new reservation
        Provider.of<ReservationModel>(context, listen: false)
            .addReservation(deleted);
      }
    }
  }

  static void custom(DateTime date, Group group, BuildContext context,
      {int amountEating: 1, bool isCooking: false, int userId}) async {
    SharedPreferences prefs;
    if (userId == null) {
      prefs = await SharedPreferences.getInstance();
      userId = prefs.getInt("userId");
    } else {
      // TODO verify user is correct
    }

    Reservation res = Reservation(group.id, date, userId,
        amountEating: amountEating, isCooking: isCooking);

    Future<Response> response;
    Reservation deleted = Provider.of<ReservationModel>(context, listen: false)
        .addReservation(res);

    try {
      response = ServerCommunication.sendReservation(res);
    } on NetworkException catch (e) {
      e.showErrorSnackbar(context);
      if (deleted == null) {
        // delete new reservation
        Provider.of<ReservationModel>(context, listen: false)
            .deleteReservation(date, prefs.getInt("userId"), group.id);
      } else {
        // re-add deleted reservation, also deletes new reservation
        Provider.of<ReservationModel>(context, listen: false)
            .addReservation(deleted);
      }
    }
  }

  static Future<List<Reservation>> getAllReservations(int groupId) async {
    Response res = await ServerCommunication.getReservationsByGroup(groupId);
    Iterable i = json.decode(res.body);
    return List<Reservation>.from(i.map((val) => Reservation.fromJson(val)));
  }

  static Future<List<User>> getUsersInGroup(int groupId) async {
    Response res = await ServerCommunication.getUsersInGroup(groupId);
    Iterable i = json.decode(res.body);
    return List<User>.from(i.map((val) => User.fromJson(val)));
  }
}
