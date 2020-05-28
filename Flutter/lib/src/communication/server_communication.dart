import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
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

  /// Generates the authentication header and saves it in memory and shared preferences
  static void setAuthHeader(String email, String pass) async {
    _auth = "Basic " + base64Encode(utf8.encode("$email:$pass"));
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString("header", _auth);
  }

  static Future<http.Response> _authenticatedGet(String url) async {
    String _url = _host + url;

    print("GET Request to " + _url);

    http.Response _res =
        await http.get(_url, headers: {HttpHeaders.authorizationHeader: await _getAuth()});
    print("Response " + _res.statusCode.toString() + ': ' +  _res.body.toString());
    return _res;
  }

  static Future<http.Response> _authenticatedPost(String url, Object obj) async {
    String _url = _host + url;
    Map<String, String> _headers = {
      HttpHeaders.authorizationHeader: await _getAuth(),
      HttpHeaders.contentTypeHeader: "application/json"
    };
    String json = jsonEncode(obj);

    print("POST request to " + url + " With body: '" + json + "'");
    Response _res =  await http
        .post(_url,
        headers: _headers,
        body: json)
        .timeout(Duration(seconds: 5));
    print("Response " + _res.statusCode.toString() + ': ' +  _res.body.toString());
    return _res;
  }

  static Future<http.Response> _authenticatedPut(String url, Object obj) async {
    String _url = _host + url;
    Map<String, String> _headers = {
      HttpHeaders.authorizationHeader: await _getAuth(),
      HttpHeaders.contentTypeHeader: "application/json"
    };
    String json = jsonEncode(obj);

    print("POST request to " + url + " With body: '" + json);
    Response _res = await http
        .put(_url,
        headers: _headers,
        body: json)
        .timeout(Duration(seconds: 5));
    print("Response " + _res.statusCode.toString() + ': ' +  _res.body.toString());
    return _res;
  }

  static Future<http.Response> _authenticatedDelete(String url) async {
    String _url = _host + url;
    Map<String, String> _headers = {
      HttpHeaders.authorizationHeader: await _getAuth(),
      HttpHeaders.contentTypeHeader: "application/json"
    };

    print("DELETE request to " + url);
    Response _res = await http
        .delete(_url,
        headers: _headers)
        .timeout(Duration(seconds: 5));
    print("Response " + _res.statusCode.toString() + ': ' +  _res.body.toString());
    return _res;
  }



  static Future<http.Response> getUserId() async {
    return await _authenticatedGet("/users/login");
  }

  static Future<http.Response> sendReservation(Reservation res) async {
    return await _authenticatedPut("/reserve", res);
  }

  static Future<http.Response> register(User user) async {
    return await http.post(_host + "/users/register", headers:
    {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(user));
    //return await authenticatedPost("/users/register", user);
  }

  static Future<http.Response> addGroup(String name) async {
    Group group = new Group.onlyName(name);
    return await _authenticatedPost("/groups/add", group);
  }

  static Future<List<Reservation>> getAllReservations(int groupId) async {
     await _authenticatedGet("/reservations/all?groupId=" + groupId.toString());
  }
  
  static Future<http.Response> getUsersFromGroup(int groupId) async{
    return await _authenticatedGet("/users/get");
  }

}
