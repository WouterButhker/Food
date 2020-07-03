
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:student/src/entities/reservation.dart';

class ReservationModel extends ChangeNotifier {
  Set<Reservation> reservations = HashSet<Reservation>();
  
  ReservationModel() {
    reservations.add(Reservation(1, DateTime.now(), 35, amountEating: 1));
  }

  get getReservationSet => reservations;


}