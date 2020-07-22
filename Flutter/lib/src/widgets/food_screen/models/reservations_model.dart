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
//    print("CREATE RESERVATIONMODEL");
//    reservations.add(Reservation(1, DateTime.now(), 36, amountEating: 1));
//    reservations.add(Reservation(1, DateTime.now().add(Duration(days: 1)), 37, isCooking: true, amountEating: 1));
////    reservations.sort();
////
////    binarySearch(reservations, Reservation(1, DateTime.now(), 0));
//    print(reservations);

    update();
  }

  void update() async {
    reservations = await FoodController.getAllReservations(group.id);
    print("Reservations: " + reservations.toString());
    notifyListeners();
  }

  List<Reservation> get getReservations => reservations;

  Group get getGroup => group;
}
