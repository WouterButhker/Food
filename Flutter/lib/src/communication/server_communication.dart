import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http; // TODO
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/network_exception.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/entities/user.dart';
import 'package:http_parser/http_parser.dart';

class ServerCommunication {

  // TODO: Convert to secure storage
  // https://pub.dev/packages/flutter_secure_storage
  /// Generates the authentication header and saves it
  static Future setAuthHeader(String email, String pass) async {
    _ServerRequests._auth = "Basic " + base64Encode(utf8.encode("$email:$pass"));
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString("header", _ServerRequests._auth);
    return;
  }

  static Future<http.Response> register(User user) async {
    return _ServerRequests.register(user);
  }

  static Future<http.StreamedResponse> uploadProfilePicture(File image) async {
    return await _ServerRequests.authenticatedMultiPart("/users/picture", image);
  }

  static Future<http.Response> getUserId() async {
    return await _ServerRequests.authenticatedGet("/users/login");
  }

  static Future<http.Response> sendReservation(Reservation res) async {
    return await _ServerRequests.authenticatedPut("/reserve", res);
  }

  static Future<http.Response> deleteReservation(Reservation res) async {
    return await _ServerRequests.authenticatedDelete("/reservations/delete?groupId=" +
        res.group.toString() +
        "&date=" +
        res.date.toIso8601String());
  }

  static Future<http.Response> addGroup(String name) async {
    Group group = new Group.onlyName(name);
    return await _ServerRequests.authenticatedPost("/groups/add", group);
  }

  static Future<http.Response> getReservationsByGroup(int groupId) async {
    return await _ServerRequests.authenticatedGet(
        "/reservations/all?groupId=" + groupId.toString());
  }

//  static Future<http.Response> getUsersFromGroup(int groupId) async {
//    return await _ServerRequests._authenticatedGet("/users/get");
//  }

  static String getProfilePictureLink(String email) {
    return _ServerRequests.host + "/users/picture?user=" + email;
  }

  static Future<NetworkImage> getProfilePicture(String email) async {
    String url = _ServerRequests.host + "/users/picture?user=" + email;
    return _ServerRequests.authenticatedNetworkImage(url);
  }

  static Future<http.Response> getUserGroups() async {
    http.Response res = await _ServerRequests.authenticatedGet("/groups/getUserGroups");
    return res;
  }

  static Future<http.Response> getUserName(int userId) async {
    return await _ServerRequests.authenticatedGet(
        "/users/getUserName?userId=" + userId.toString());
  }

  static Future<http.Response> getUsersInGroup(int groupId) async {
    return await _ServerRequests.authenticatedGet(
        "/users/getUsersInGroup?groupId=" + groupId.toString());
  }
}

class _ServerRequests {
  static const String host = String.fromEnvironment('HOST', defaultValue: "http://192.168.2.3:8080");
  static String _auth;
  static const int timeoutInSeconds = 5;


  static Future<String> getAuth() async {
    if (_auth != null) return _auth;

    final _pref = await SharedPreferences.getInstance();
    _auth = _pref.get("header");
    return _auth;
  }

  /// Makes an authenticated GET request to [url] and returns the response.
  ///
  /// if a context is supplied, errors will be handled nicely
  static Future<http.Response> authenticatedGet(String url) async {
    String _url = host + url;

    print("GET Request to " + _url);

    http.Response res = await http.get(_url, headers: {
      HttpHeaders.authorizationHeader: await getAuth()
    }).timeout(Duration(seconds: timeoutInSeconds), onTimeout: () {
      throw NetworkException(message: "Network timed out");
    });

    if (res != null)
      print(
          "Response " + res.statusCode.toString() + ': ' + res.body.toString());

    if (res == null || res.statusCode != 200) {
      throw NetworkException(response: res);
    }

    return res;
  }

  static Future<http.Response> authenticatedPost(String url, Object obj) async {
    String _url = host + url;
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

    if (res != null)
      print(
          "Response " + res.statusCode.toString() + ': ' + res.body.toString());
    if (res == null || res.statusCode != 200) {
      throw NetworkException(response: res);
    }

    return res;
  }

  static Future<http.Response> authenticatedPut(String url, Object obj) async {
    String _url = host + url;
    Map<String, String> _headers = {
      HttpHeaders.authorizationHeader: await getAuth(),
      HttpHeaders.contentTypeHeader: "application/json"
    };
    String json = jsonEncode(obj);

    print("POST request to " + url + " With body: '" + json);
    Response res = await http
        .put(_url, headers: _headers, body: json)
        .timeout(Duration(seconds: timeoutInSeconds), onTimeout: () {
      throw NetworkException(message: "Network timed out");
    });

    if (res != null)
      print(
          "Response " + res.statusCode.toString() + ': ' + res.body.toString());
    if (res == null || res.statusCode != 200) {
      throw NetworkException(response: res);
    }

    return res;
  }

  static Future<http.Response> authenticatedDelete(String url) async {
    String _url = host + url;
    Map<String, String> _headers = {
      HttpHeaders.authorizationHeader: await getAuth(),
      HttpHeaders.contentTypeHeader: "application/json"
    };

    print("DELETE request to " + url);
    Response res = await http
        .delete(_url, headers: _headers)
        .timeout(Duration(seconds: timeoutInSeconds), onTimeout: () {
      throw NetworkException(message: "Network timed out");
    });

    if (res != null)
      print(
          "Response " + res.statusCode.toString() + ': ' + res.body.toString());
    if (res == null || res.statusCode != 200) {
      throw NetworkException(response: res);
    }
    return res;
  }

  static Future<http.Response> register(User user) async {
    String url = host + "/users/register";
    var json = jsonEncode(user);
    print("POST request (no auth) to " + url + " With body: '" + json + "'");

    http.Response res = await http.post(url,
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: json);

    print("Response " + res.statusCode.toString() + ': ' + res.body.toString());
    return res;
  }

  static Future<http.StreamedResponse> authenticatedMultiPart(
      String url, File file) async {
    print('MultiPart request to ' + url);
    Uri uri = Uri.parse(host + url);
    var request = http.MultipartRequest("POST", uri);
    //request.fields["user"] = "test";
    request.headers[HttpHeaders.authorizationHeader] = await getAuth();
    request.files.add(http.MultipartFile.fromBytes(
        "file", await file.readAsBytes(),
        filename: "file", contentType: MediaType("image", "jpg")));

    http.StreamedResponse res = await request
        .send()
        .timeout(Duration(seconds: timeoutInSeconds), onTimeout: () {
      throw NetworkException(message: "Network timed out");
    });

    if (res != null)
      print("Response " +
          res.statusCode.toString() +
          ', length ' +
          res.contentLength.toString());

    if (res == null || res.statusCode != 200) {
      throw NetworkException(streamedResponse: res);
    }

    return res;
  }

  static Future<NetworkImage> authenticatedNetworkImage(String url) async {
    return NetworkImage(url,
        headers: {HttpHeaders.authorizationHeader: await getAuth()});
  }
}