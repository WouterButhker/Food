import 'package:flutter/material.dart';

class DateSelectionModel extends ChangeNotifier {
  DateTime selectedDate;

  DateSelectionModel(this.selectedDate);

  void goToNextDay() {
    selectedDate = selectedDate.add(Duration(days: 1));
    notifyListeners();
  }

  void goToPreviousDay() {
    selectedDate = selectedDate.subtract(Duration(days: 1));
    notifyListeners();
  }

  void goToSpecificDay(DateTime date) {
    if (date == null) return;
    selectedDate = date;
    notifyListeners();
  }

  get getSelectedDate => selectedDate;
}
