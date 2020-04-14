import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
    accentColor: Colors.orangeAccent,
    buttonColor: Colors.orangeAccent);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.orangeAccent,
);

class ThemeModel extends ChangeNotifier {
  ThemeData _themeData = myTheme;
  String _currentTheme = "Light";

  ThemeData get theme => _themeData;
  String get currentTheme => _currentTheme;

  void changeTheme() {
    if (_currentTheme == "Light") {
      _themeData = darkTheme;
      _currentTheme = "Dark";
    }
    else {
      _themeData = myTheme;
      _currentTheme = "Light";
    }
    notifyListeners();
  }
}

class ThemeButtonModel extends ChangeNotifier {
  String _buttonText = "Dark mode";

  String get buttonText => _buttonText;

  void changeText() {
    if (_buttonText == "Dark mode") _buttonText = "Light mode";
    else _buttonText = "Dark mode";
    notifyListeners();
  }
}


