import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/src/widgets/mainscreen.dart';
import 'package:student/src/widgets/food.dart';
import 'package:student/src/widgets/login.dart';
import 'package:student/src/theme/theme.dart';

void main() async {
  // make sure the theme is loaded before the application displays
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final ThemeState themeState = ThemeState(prefs);

  runApp(MyApp(themeState: themeState));
}

class MyApp extends StatelessWidget {
  final ThemeState themeState;

  MyApp({Key key, this.themeState}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => themeState,
      child: Consumer<ThemeState>(
        builder: (context, theme, child) {
          return MaterialApp(
              title: 'Student tools',
              initialRoute: '/login',
              routes: {
                '/login': (context) => Login(),
                '/main': (context) => MainScreen(),
                '/food': (context) => Food(),
              },
              theme: theme.theme);
        },
      ),
    );
  }
}
