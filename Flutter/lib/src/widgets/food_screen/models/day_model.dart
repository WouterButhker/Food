
import 'package:flutter/cupertino.dart';
import 'package:student/src/controllers/food_controller.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/entities/user.dart';
import 'package:student/src/controllers/date_only_compare.dart';
import 'date_selection_model.dart';
import 'reservations_model.dart';

class DayModel extends ChangeNotifier {

  DateSelectionModel dateSelectionModel;
  ReservationModel reservationModel;
  List<Reservation> reservationsForDay;
  List<User> usersInGroup = [];

  DayModel() {
    reservationsForDay = [];
  }

  void update(DateSelectionModel dateSelectionModelParam, ReservationModel reservationModelParam) async {
    dateSelectionModel = dateSelectionModelParam;
    reservationModel = reservationModelParam;
    List<Reservation> oldDayReservations = reservationsForDay;
    reservationsForDay = [];

    // generate list of reservations for this specific day
    for (Reservation res in this.reservationModel.reservations) {
      if (res.date.isSameDate(dateSelectionModel.selectedDate)) {
        this.reservationsForDay.add(res);
      }
    }

    if (usersInGroup.isEmpty) usersInGroup = await FoodController.getUsersInGroup(reservationModel.getGroup.id);

    if (oldDayReservations != reservationsForDay) notifyListeners();
  }

}