

import 'package:flutter/cupertino.dart';

class DayOrWeekModel extends ChangeNotifier {

  bool dayView = true;
  AnimationController animationController;

  void changeView() {
    dayView = !dayView;
    notifyListeners();
  }
}