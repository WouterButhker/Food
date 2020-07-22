
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/controllers/food_controller.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/entities/user.dart';
import 'package:student/src/widgets/food_screen/models/reservations_model.dart';
import 'package:student/src/controllers/date_only_compare.dart';

import '../day_summary.dart';
import 'date_selection_model.dart';

class DaySummaryModel with ChangeNotifier {
  DateSelectionModel _dateSelectionModel;
  ReservationModel _reservationModel;
  List<Reservation> reservationsForDay;
  List<User> _usersInGroup;

  int eating = 0;
  int notEating = 0;
  int notResponded = 0;
  String cook = "?";


  // TODO: get values from language helper
  String eatingText = " Eten mee";
  String notEatingText = " Eten niet mee";
  String notRespondedText = " Hebben niet gereageerd";
  String cookText = " Kookt";

  DaySummaryModel(){
    init();
  }

  void init() {
    this.eating = 0;
    this.notEating = 0;
    this.notResponded = 0;
    this.cook = "?";
    this.reservationsForDay = [];
  }

  void update(DateSelectionModel dateSelectionModel,
      ReservationModel reservationModel) async {
    init();

    this._dateSelectionModel = dateSelectionModel;
    this._reservationModel = reservationModel;

    // generate list of reservations for this specific day
    for (Reservation res in this._reservationModel.reservations) {
      if (res.date.isSameDate(_dateSelectionModel.selectedDate)) {
        this.reservationsForDay.add(res);
      }
    }

    if (_usersInGroup == null) _usersInGroup = await FoodController.getUsersInGroup(_reservationModel.getGroup.id);

    List<int> notRespondedUsers = _usersInGroup.map((user) => user.id).toList();

    for(Reservation res in reservationsForDay) {
      notRespondedUsers.remove(res.user);

      if (res.amountEating == 0) {
        this.notEating++;
      } else{
        this.eating += res.amountEating;
      }

      if (res.isCooking) {
        for (User user in _usersInGroup) {
          if (res.user == user.id) {
            this.cook = user.name;
            break; // TODO handle multiple cooks
          }
        }
      }
    }

    this.notResponded = notRespondedUsers.length;
    

    notifyListeners();
  }
}