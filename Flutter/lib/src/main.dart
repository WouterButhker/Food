import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/src/widgets/mainscreen.dart';
import 'package:student/src/widgets/food.dart';
import 'package:student/src/widgets/login.dart';
import 'package:student/src/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeState(),
      child: Consumer<ThemeState>(
        builder: (context, theme, child) {
          return MaterialApp(
              title: 'Student tools',
              initialRoute: '/main',
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
