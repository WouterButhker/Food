
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/controllers/food_controller.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/entities/user.dart';
import 'package:student/src/widgets/food_screen/models/reservations_model.dart';
import 'package:student/src/widgets/food_screen/models/day_model.dart';

import '../day_summary.dart';
import 'date_selection_model.dart';

class DaySummaryModel with ChangeNotifier {
  DayModel dayModel;


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
  }

  void update(DayModel dayModel) async {
    init();

    List<int> notRespondedUsers = dayModel.usersInGroup.map((user) => user.id).toList();

    for(Reservation res in dayModel.reservationsForDay) {
      notRespondedUsers.remove(res.user);

      if (res.amountEating == 0) {
        this.notEating++;
      } else{
        this.eating += res.amountEating;
      }

      if (res.isCooking) {
        for (User user in dayModel.usersInGroup) {
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
