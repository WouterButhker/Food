

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/src/models/language_model.dart';
import 'package:student/src/theme/theme.dart';

class SettingsModel extends ChangeNotifier {
  String _language;
  String _theme;

  SettingsModel() {
    _init();
    print("CREATE SETTINGSMODEL");
  }

  void _init() async {
    final prefs = await SharedPreferences.getInstance();
    _language = prefs.getString("language") ?? "en";
    _theme = prefs.getString("theme") ?? "Light";
    notifyListeners();
  }

  String get language => this._language;

  String get theme => this._theme;

  void setTheme(String theme, BuildContext context) {
    if (_theme == theme) return;
    _theme = theme;
    notifyListeners();

    Provider.of<ThemeState>(context, listen: false).changeTheme();
  }

  void setLanguage(String newLang, BuildContext context) {
    // change radio button
    if (_language == newLang) return;
    _language = newLang;
    notifyListeners();

    // change language in full app
    Provider.of<LanguageModel>(context, listen: false).changeLanguage(Locale(newLang));
  }

}