import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServerCommunication {
  static String _host = "http://192.168.0.172:8080";
  static String _auth;

  static void authenticatedGet(String url) async {
    String _url = _host + url;
    String _user = "Wouter";
    String _pass = "123";
    String _auth = "Basic " + base64Encode(utf8.encode("$_user:$_pass"));
    print("Request");

    http.Response _res = await http.get(
        _url, headers: {HttpHeaders.authorizationHeader : _auth});
    print("Response: " + _res.body.toString());
  }

  static Future<http.Response> login(String email, String pass) async {
    String _url = _host + "/login";
    _auth = "Basic " + base64Encode(utf8.encode("$email:$pass"));
    Map<String,String> _headers = {HttpHeaders.authorizationHeader : _auth};
    print(_headers.toString());

    http.Response _res = await http.get(_url, headers: _headers).timeout(Duration(seconds: 5));
    if (_res.statusCode == 200) {
      // save user info
    }
  }

  static void saveUserData(String email, int id) async {
    final _prefs = await SharedPreferences.getInstance();

    _prefs.setString("email", email);
    _prefs.setString("header", _auth);
    _prefs.setInt("userId", id);

  }
}