

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageModel extends ChangeNotifier {
  Locale _appLocale;
  SharedPreferences _prefs;

  LanguageModel(this._prefs);

  Locale get appLocale => _appLocale;

  fetchLocale() {
    if (_prefs.getString("language") == null) return;
    _appLocale = Locale(_prefs.getString("language"));
  }

  void changeLanguage(Locale lang) async {
    if (_appLocale == lang) return;

    _appLocale = lang;
    _prefs.setString("language", lang.languageCode);
    notifyListeners();
  }


}