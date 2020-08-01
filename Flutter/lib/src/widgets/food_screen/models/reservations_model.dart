import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/controllers/food_controller.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/controllers/date_only_compare.dart';

class ReservationModel extends ChangeNotifier {
  List<Reservation> reservations = [];
  final Group group;

  ReservationModel(this.group) {
    update();
  }

  void update() async {
    reservations = await FoodController.getAllReservations(group.id);
    notifyListeners();
    reservations.sort();
  }

  void addReservation(Reservation res) {
    if (res == null || reservations.contains(res)) return;

    _deleteReservation(res.date, res.user, res.group);
    reservations.add(res);
    notifyListeners();
    reservations.sort();
  }

  void deleteReservation(DateTime date, int userId, int groupId) {
    bool deleted = _deleteReservation(date, userId, groupId);
    if (deleted) notifyListeners();
  }

  bool _deleteReservation(DateTime date, int userId, int groupId) {
    int pos = binarySearch(reservations, Reservation(null, date, null));
    if (pos == -1) return false;

    for (int i = pos; i < reservations.length; i++) {
      Reservation res = reservations[i];

      if (!res.date.isSameDate(date)) return false;

      if (res.user == userId && res.group == groupId && res.date.isSameDate(date)) {
        reservations.removeAt(i);
        return true;
      }
    }
    return false;
  }

  List<Reservation> get getReservations => reservations;

  Group get getGroup => group;
}
