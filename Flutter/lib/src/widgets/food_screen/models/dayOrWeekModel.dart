

import 'package:flutter/cupertino.dart';

class DayOrWeekModel extends ChangeNotifier {

  bool dayView = true;

  void changeView() {
    dayView = !dayView;
    notifyListeners();
  }
}