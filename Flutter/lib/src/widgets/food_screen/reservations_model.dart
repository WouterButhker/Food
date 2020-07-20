
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/controllers/date_only_compare.dart';

class ReservationModel extends ChangeNotifier {

  List<Reservation> reservations = [];
  final Group group;
  
  ReservationModel(this.group) {
    print("CREATE RESERVATIONMODEL");
    reservations.add(Reservation(1, DateTime.now(), 35, amountEating: 1));
    reservations.add(Reservation(1, DateTime.now(), 36, amountEating: 1));
    reservations.add(Reservation(1, DateTime.now().add(Duration(days: 1)), 37, isCooking: true, amountEating: 1));

//    reservations.sort();
//
//    binarySearch(reservations, Reservation(1, DateTime.now(), 0));


    print(reservations);
  }

  get getReservationSet => reservations;

  int getEatingAt(DateTime date) {
    int eating = 0;
    for (Reservation res in reservations) {
      if (res.date.isSameDate(date)) {
        eating += res.amountEating;
      }
    }
    return eating;
  }



}