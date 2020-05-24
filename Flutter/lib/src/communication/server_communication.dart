import 'dart:convert';
import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/entities/user.dart';

class ServerCommunication {
  static String _host = "http://192.168.0.173:8080";
  static String _auth;

  static Future<String> _getAuth() async {
    if (_auth != null) return _auth;
    final _pref = await SharedPreferences.getInstance();
    _auth = _pref.get("header");
    return _auth;
  }

  static Future<http.Response> authenticatedGet(String url) async {
    String _url = _host + url;
    String _user = "Wouter";
    String _pass = "123";
    String _auth = "Basic " + base64Encode(utf8.encode("$_user:$_pass"));
    print("Request");

    http.Response _res =
        await http.get(_url, headers: {HttpHeaders.authorizationHeader: await _getAuth()});
    print("Response " + _res.statusCode.toString() + ': ' +  _res.body.toString());
    return _res;
  }

  static Future<http.Response> authenticatedPost(String url, Object obj) async {
    String _url = _host + url;
    Map<String, String> _headers = {
      HttpHeaders.authorizationHeader: await _getAuth(),
      HttpHeaders.contentTypeHeader: "application/json"
    };
    print("Making post request to " + url + " With body: '" + jsonEncode(obj) + "'");
    return await http
        .post(_url,
        headers: _headers,
        body: jsonEncode(obj))
        .timeout(Duration(seconds: 5));
  }

  static Future<http.Response> authenticatedPut(String url, Object obj) async {
    String _url = _host + url;
    Map<String, String> _headers = {
      HttpHeaders.authorizationHeader: await _getAuth(),
      HttpHeaders.contentTypeHeader: "application/json"
    };
    print("Making post request to " + url + " With body: '" + jsonEncode(obj) + "' and headers: " + _headers.toString());
    return await http
        .put(_url,
        headers: _headers,
        body: jsonEncode(obj))
        .timeout(Duration(seconds: 5));
  }


  static Future<http.Response> login(String email, String pass) async {
    String _url = _host + "/login";
    _auth = "Basic " + base64Encode(utf8.encode("$email:$pass"));
    Map<String, String> _headers = {HttpHeaders.authorizationHeader: _auth};
    print(_headers.toString());

    http.Response _res =
        await http.get(_url, headers: _headers).timeout(Duration(seconds: 5));
    if (_res.statusCode == 200) {
      // save user info
      saveUserData(email, int.parse(_res.body));
    }
    return _res;
  }

  static void saveUserData(String email, int id) async {
    final _prefs = await SharedPreferences.getInstance();

    _prefs.setString("email", email);
    _prefs.setString("header", _auth);
    _prefs.setInt("userId", id);
    _prefs.setBool("loggedIn", true);
  }

  static Future<http.Response> sendReservation(Reservation res) async {
    return await authenticatedPut("/reserve", res);
  }

  static Future<http.Response> register(User user) async {
    return await authenticatedPost("/users/register", user);
  }

  static Future<http.Response> addGroup(String name) async {
    Group group = new Group.onlyName(name);
    return await authenticatedPost("/groups/add", group);
  }

  static Future<List<Reservation>> getAllReservations(int groupId) async {
     await authenticatedGet("/reservations/all?groupId=" + groupId.toString());
  }
  
  static Future<http.Response> getUsersFromGroup(int groupId) async{
    return await authenticatedGet("/users/get");
  }

}
