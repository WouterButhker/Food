import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/src/main.dart';

ThemeData myTheme = ThemeData(
    accentColor: Colors.orangeAccent,
    buttonColor: Colors.orangeAccent);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.orangeAccent,
);

class ThemeState extends ChangeNotifier {
  var _prefs;

  ThemeData _themeData = myTheme;
  String _currentTheme = "Light";

  ThemeState(prefs) {
    this._prefs = prefs;
    if ((_prefs.getString("theme") ?? "Light") == "Dark") {
      _themeData = darkTheme;
      _currentTheme = "Dark";
    }
  }

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
    _prefs.setString("theme", _currentTheme);
    notifyListeners();
  }
}

class ThemeButtonState extends ChangeNotifier {
  String _buttonText ="";

  ThemeButtonState()  {
    initText();
  }

  void initText() async {
    final _prefs = await SharedPreferences.getInstance();
    _buttonText = _getButtonTextFromTheme(_prefs.getString("theme") ?? "Light");

    // button might have been displayed before the correct value was loaded
    notifyListeners();
  }

  String get buttonText => _buttonText;

  void changeText() {
    if (_buttonText == "Dark mode") _buttonText = "Light mode";
    else _buttonText = "Dark mode";
    notifyListeners();
  }

  String _getButtonTextFromTheme(String theme) {
    switch(theme) {
      case "Light":
        return "Dark mode";
      default:
        return "Light mode";
    }
  }
}


