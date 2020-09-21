import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/network_exception.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/entities/user.dart';
import 'package:http_parser/http_parser.dart';

class ServerCommunication {
  static String _host = "http://192.168.0.190:8080";
  static int timeoutInSeconds = 5;
  static String _auth;

  static Future<String> getAuth() async {
    if (_auth != null) return _auth;

    final _pref = await SharedPreferences.getInstance();
    _auth = _pref.get("header");
    return _auth;
  }

  /// Generates the authentication header and saves it in memory and shared preferences
  static Future setAuthHeader(String email, String pass) async {
    _auth = "Basic " + base64Encode(utf8.encode("$email:$pass"));
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString("header", _auth);
    return;
  }

  /// Makes an authenticated request to [url] and returns the response.
  ///
  /// if a context is supplied, errors will be handled nicely
  static Future<http.Response> _authenticatedGet(String url, {BuildContext context}) async {
    String _url = _host + url;

    print("GET Request to " + _url);

    http.Response res = await http.get(_url, headers: {
      HttpHeaders.authorizationHeader: await getAuth()
    }).timeout(Duration(seconds: timeoutInSeconds), onTimeout: () {
      _handleError(null, context);
      return;
    });

    if (res != null) print(
        "Response " + res.statusCode.toString() + ': ' + res.body.toString());

    if (res == null || res.statusCode != 200) {
      _handleError(res, context);
    }

    return res;
  }

  static Future<http.Response> _authenticatedPost(
      String url, Object obj, {BuildContext context}) async {
    String _url = _host + url;
    Map<String, String> _headers = {
      HttpHeaders.authorizationHeader: await getAuth(),
      HttpHeaders.contentTypeHeader: "application/json"
    };
    String json = jsonEncode(obj);

    print("POST request to " + url + " With body: '" + json + "'");
    Response res = await http
        .post(_url, headers: _headers, body: json)
        .timeout(Duration(seconds: timeoutInSeconds), onTimeout: () {
      throw NetworkException(message: "Network timed out");
    });

    if (res != null) print(
        "Response " + res.statusCode.toString() + ': ' + res.body.toString());
    if (res == null || res.statusCode != 200) {
      throw NetworkException(response: res);
    }

    return res;
  }

  static Future<http.Response> _authenticatedPut(String url, Object obj, {BuildContext context}) async {
    String _url = _host + url;
    Map<String, String> _headers = {
      HttpHeaders.authorizationHeader: await getAuth(),
      HttpHeaders.contentTypeHeader: "application/json"
    };
    String json = jsonEncode(obj);

    print("POST request to " + url + " With body: '" + json);
    Response res = await http
        .put(_url, headers: _headers, body: json)
        .timeout(Duration(seconds: timeoutInSeconds), onTimeout: () {
      _handleError(null, context);
      return;
    });

    if (res != null) print(
        "Response " + res.statusCode.toString() + ': ' + res.body.toString());
    if (res == null || res.statusCode != 200) {
      _handleError(res, context);
    }

    return res;
  }

  static Future<http.Response> _authenticatedDelete(String url, {BuildContext context}) async {
    String _url = _host + url;
    Map<String, String> _headers = {
      HttpHeaders.authorizationHeader: await getAuth(),
      HttpHeaders.contentTypeHeader: "application/json"
    };

    print("DELETE request to " + url);
    Response res = await http
        .delete(_url, headers: _headers)
        .timeout(Duration(seconds: timeoutInSeconds), onTimeout: () {
          _handleError(null, context);
          return;
    });


    if (res != null) print(
        "Response " + res.statusCode.toString() + ': ' + res.body.toString());
    if (res == null || res.statusCode != 200) {
      _handleError(res, context);
    }
    return res;
  }

  static Future<http.Response> register(User user) async {
    String url = _host + "/users/register";
    var json = jsonEncode(user);
    print("POST request (no auth) to " + url + " With body: '" + json + "'");

    http.Response res = await http.post(url,
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: json);

    print("Response " + res.statusCode.toString() + ': ' + res.body.toString());
    return res;
  }

  static Future<http.StreamedResponse> _authenticatedMultiPart(
      String url, File file, {BuildContext context}) async {
    print('MultiPart request to ' + url);
    Uri uri = Uri.parse(_host + url);
    var request = http.MultipartRequest("POST", uri);
    //request.fields["user"] = "test";
    request.headers[HttpHeaders.authorizationHeader] = await getAuth();
    request.files.add(http.MultipartFile.fromBytes(
        "file", await file.readAsBytes(),
        filename: "file", contentType: MediaType("image", "jpg")));

    http.StreamedResponse res = await request.send().timeout(Duration(seconds: timeoutInSeconds), onTimeout: () {
      _handleError(null, context);
      return;
    });

    if (res != null) print("Response " +
        res.statusCode.toString() +
        ', length ' +
        res.contentLength.toString());

    if (res == null || res.statusCode != 200) {
      _handleStreamError(res, context);
    }

    return res;
  }

  /// Show snackbar with a specified error.
  ///
  /// if res is null, assume timeout
  /// otherwise, show status code and message of res
  static void _handleError(http.Response res, BuildContext context) {
    // TODO: make this an exception
    if (context == null) {
      print("No context supplied, cannot show network error to user");
      return;
    }

    String errorText;
    if (res == null) {
      errorText = "Request timed out";
    } else {
      Map<String, dynamic> jsonResponse = json.decode(res.body);
      errorText = "Error " + res.statusCode.toString() + ": " + jsonResponse["message"];
    }

    final snackBar = SnackBar(
      content: Text(errorText),
      duration: Duration(seconds: 60),
      backgroundColor: Theme.of(context).errorColor,
      action: SnackBarAction(
        onPressed: () {},
        label: Localizations.of<MaterialLocalizations>(context, MaterialLocalizations).okButtonLabel,
      ),
    );
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
  }

  // TODO test this method
  static void _handleStreamError(http.StreamedResponse res, BuildContext context) {
    print('Network error');
    final snackBar = SnackBar(
      content: Text("Error communicating with server " + res.statusCode.toString() + ": " + res.stream.toString()),
      duration: Duration(seconds: 60),
      backgroundColor: Theme.of(context).errorColor,
      action: SnackBarAction(
        onPressed: () {},
        label: "Oh",
      ),
    );
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static Future<http.StreamedResponse> uploadProfilePicture(File image) async {
    return await _authenticatedMultiPart("/users/picture", image);
  }

  static Future<http.Response> getUserId() async {
    return await _authenticatedGet("/users/login");
  }

  static Future<http.Response> sendReservation(Reservation res, BuildContext context) async {
    return await _authenticatedPut("/reserve", res, context: context);
  }
  
  static Future<http.Response> deleteReservation(Reservation res) async {
    return await _authenticatedDelete("/reservations/delete?groupId=" + res.group.toString() + "&date=" + res.date.toIso8601String());
  }

  static Future<http.Response> addGroup(String name) async {
    Group group = new Group.onlyName(name);
    return await _authenticatedPost("/groups/add", group);
  }

  static Future<http.Response> getReservationsByGroup(int groupId) async {
    return await _authenticatedGet("/reservations/all?groupId=" + groupId.toString());
  }

//  static Future<http.Response> getUsersFromGroup(int groupId) async {
//    return await _authenticatedGet("/users/get");
//  }

  static String getProfilePictureLink(String email) {
    return _host + "/users/picture?user=" + email;
  }

  static Future<NetworkImage> getProfilePicture(String email) async {
    String url = _host + "/users/picture?user=" + email;
    return NetworkImage(url, headers: {HttpHeaders.authorizationHeader: await getAuth()});
  }

  static Future<http.Response> getUserGroups() async {
    http.Response res = await _authenticatedGet("/groups/getUserGroups");
    return res;
  }

  static Future<http.Response> getUserName(int userId) async {
    return await _authenticatedGet("/users/getUserName?userId=" + userId.toString());
  }

  static Future<http.Response> getUsersInGroup(int groupId) async {
    return await _authenticatedGet("/users/getUsersInGroup?groupId=" + groupId.toString());
  }

}
