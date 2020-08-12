import 'package:flutter/material.dart';

class DateSelectionModel extends ChangeNotifier {
  DateTime selectedDate;
  bool dayView = true;
  AnimationController animationController;

  DateSelectionModel(this.selectedDate);

  void goToNext() {
    if (dayView) {
      selectedDate = selectedDate.add(Duration(days: 1));
    } else {
      int dayOfTheWeek = selectedDate.weekday;
      int daysToNextMonday = 8 - dayOfTheWeek;
      selectedDate = selectedDate.add(Duration(days: daysToNextMonday));
    }
    notifyListeners();
  }

  void goToPrevious() {
    if (dayView) {
      selectedDate = selectedDate.subtract(Duration(days: 1));
    } else {
      int dayOfTheWeek = selectedDate.weekday;
      int daysToPreviousMonday = dayOfTheWeek - 1;
      if (daysToPreviousMonday == 0) daysToPreviousMonday = 7;
      selectedDate = selectedDate.subtract(Duration(days: daysToPreviousMonday));
      notifyListeners();
    }
  }

  void goToSpecific(DateTime date) {
    if (date == null) return;
    selectedDate = date;
    if (selectedDate.weekday != DateTime.monday) goToPrevious(); // go to first day of the week
    notifyListeners();
  }

  void changeView() {
    dayView = !dayView;
    notifyListeners();
  }

  get getSelectedDate => selectedDate;
}
