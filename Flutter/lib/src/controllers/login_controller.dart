import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:password_strength/password_strength.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/entities/user.dart';

class LoginController {

  static String validateEmail(String email) {
    // according to HTML5 spec
    String _emailPattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

    if (email.isEmpty) {
      return "Please enter an email address";
    }
    if (RegExp(_emailPattern).hasMatch(email)) return null;

    return "Incorrect email address";
  }

  static String checkPasswordStrength(String password) {
    double strength = estimatePasswordStrength(password);
    print("Strength is " + strength.toString());
    if (strength < 0.5)
      return "Password too weak (" + (strength * 100).ceil().toString() +
          "/50)";
    return null;
  }

  static String checkPasswordsMatch(String pass1, String pass2) {
    if (pass2.isEmpty) {
      return "Please retype your password";
    }
    if (pass1 != pass2) {
      return "Passwords do not match";
    }
  }

  static void register(String email, String name, String password, bool marketing, context) async {
    User user = new User(null, email, name, password);
    Response res = await ServerCommunication.register(user);
    if (res.statusCode == 200 || res.statusCode == 202) {
      Navigator.pushReplacementNamed(context, '/login');
      user = json.decode(res.body);
      _saveUserData(email, user.id);

      // TODO show message to confirm email
    }
  }

  static void _saveUserData(String email, int id) async {
    final _prefs = await SharedPreferences.getInstance();

    _prefs.setString("email", email);
    _prefs.setInt("userId", id);
    _prefs.setBool("loggedIn", true);
    print("saved login data");
  }

  static void logout(context) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool("loggedIn", false);
    prefs.setString("email", null);
    prefs.setInt("userId", null);

    Navigator.pushReplacementNamed(context, "/login");
  }

  static void login(String email, String pass) async {
    await ServerCommunication.setAuthHeader(email, pass);

    Response res = await ServerCommunication.getUserId().catchError((error) {
      throw new Exception("Can't reach server");
    });

    if (res.statusCode != 200) {
      throw new Exception("Failed to login");
    }
    int id = int.parse(res.body.toString());
    _saveUserData(email, id);
    print('Login successful');
  }

}