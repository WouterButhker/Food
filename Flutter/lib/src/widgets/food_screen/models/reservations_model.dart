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

  /// Adds a new reservation and notifies listeners.
  ///
  /// Deletes a reservation if there already exists one for the same date, group and user.
  /// Returns the deleted reservation, or null.
  Reservation addReservation(Reservation res) {
    if (res == null || reservations.contains(res)) return null;

    Reservation deleted = _deleteReservation(res.date, res.user, res.group);

    if (deleted == res) {
      // undo deletion and do not call notifyListeners
      reservations.add(res);
      return null;
    }
    reservations.add(res);
    notifyListeners();
    reservations.sort();
    return deleted;
  }

  /// Deletes a reservation with the specified [date], [userId] and [groupId] and notifies listeners.
  ///
  /// Assumes the reservations list is sorted by date.
  /// Returns the deleted reservation or [null].
  Reservation deleteReservation(DateTime date, int userId, int groupId) {
    Reservation deleted = _deleteReservation(date, userId, groupId);

    if (deleted != null) notifyListeners();
    return deleted;
  }

  Reservation _deleteReservation(DateTime date, int userId, int groupId) {
    int pos = binarySearch(reservations, Reservation(null, date, null));
    if (pos == -1) return null;

    for (int i = pos; i < reservations.length; i++) {
      Reservation res = reservations[i];

      if (!res.date.isSameDate(date)) return null;

      if (res.user == userId && res.group == groupId && res.date.isSameDate(date)) {
        return reservations.removeAt(i);
      }
    }
    return null;
  }

  List<Reservation> get getReservations => reservations;

  Group get getGroup => group;
}
