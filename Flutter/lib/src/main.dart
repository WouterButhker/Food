import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/src/models/language_model.dart';
import 'package:student/src/theme/app_localizations.dart';
import 'package:student/src/widgets/main_screen.dart';
import 'package:student/src/widgets/food_screen.dart';
import 'package:student/src/widgets/login_screen.dart';
import 'package:student/src/theme/theme.dart';
import 'package:student/src/widgets/register_screen.dart';
import 'package:student/src/widgets/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // make sure the theme is loaded before the application displays
  final prefs = await SharedPreferences.getInstance();
  final ThemeState themeState = ThemeState(prefs);

  // load the correct language
  final LanguageModel languageModel = LanguageModel(prefs);
  languageModel.fetchLocale();

  // check if user has logged in before to determine the start page
  final bool loggedIn = prefs.getBool("loggedIn") ?? false;
  String startPage = loggedIn ? "/main" : "/login";
  // String startPage = prefs.getBool("loggedIn") ?? false ? "/main" : "/login"

  runApp(MyApp(
    themeState: themeState,
    startPage: startPage,
    languageModel: languageModel,
  ));
}

class MyApp extends StatelessWidget {
  final ThemeState themeState;
  final String startPage;
  final LanguageModel languageModel;

  MyApp({Key key, this.themeState, this.startPage, this.languageModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeState),
        ChangeNotifierProvider.value(value: languageModel),
      ],
      child: Consumer2<ThemeState, LanguageModel>(
        builder: (context, theme, languageModel, child) {
          return MaterialApp(
            title: 'Student tools',
            initialRoute: startPage,
            routes: {
              '/login': (context) => LoginScreen(),
              '/main': (context) => MainScreen(),
              '/food': (context) => Food(),
              '/register': (context) => Register(),
              '/settings': (context) => SettingsScreen(),
            },
            locale: languageModel.appLocale,
            supportedLocales: [
              const Locale('en'),
              const Locale('nl'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: theme.theme,
          );
        },
      ),
    );
  }
}
