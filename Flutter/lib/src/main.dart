import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/src/widgets/mainscreen.dart';
import 'package:student/src/widgets/food.dart';
import 'package:student/src/widgets/login.dart';
import 'package:student/src/theme/theme.dart';
import 'package:student/src/widgets/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // make sure the theme is loaded before the application displays
  final prefs = await SharedPreferences.getInstance();
  final ThemeState themeState = ThemeState(prefs);

  // check if user has logged in before to determine the start page
  final bool loggedIn = prefs.getBool("loggedIn") ?? false;
  String startPage = loggedIn ? "/main" : "/login";
  // String startPage = prefs.getBool("loggedIn") ?? false ? "/main" : "/login"

  runApp(MyApp(
    themeState: themeState,
    startPage: startPage,
  ));
}

class MyApp extends StatelessWidget {
  final ThemeState themeState;
  final String startPage;

  MyApp({Key key, this.themeState, this.startPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => themeState,
      child: Consumer<ThemeState>(
        builder: (context, theme, child) {
          return MaterialApp(
              title: 'Student tools',
              initialRoute: startPage,
              routes: {
                '/login': (context) => Login(),
                '/main': (context) => MainScreen(),
                '/food': (context) => Food(),
                '/register': (context) => Register(),
              },
              theme: theme.theme);
        },
      ),
    );
  }
}
