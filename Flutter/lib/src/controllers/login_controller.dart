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
    User user = new User(email, name, password);
    Response res = await ServerCommunication.register(user);
    if (res.statusCode == 200 || res.statusCode == 202) {
      //Navigator.pushReplacementNamed(context, '/login');
    }
  }

  static void _saveUserData(String email, int id, String authHeader) async {
    final _prefs = await SharedPreferences.getInstance();

    _prefs.setString("email", email);
    _prefs.setString("header", authHeader);
    _prefs.setInt("userId", id);
    _prefs.setBool("loggedIn", true);
  }

  static void login(String email, String pass) async {
    Response res = await ServerCommunication.login(email, pass);

    if (res.statusCode != 200) {
      throw new Exception("Failed to login");
    }
    int id = int.parse(res.body.toString());
    String authHeader = await ServerCommunication.getAuth();
    _saveUserData(email, id, authHeader);
  }

}