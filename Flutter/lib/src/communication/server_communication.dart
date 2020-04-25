import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ServerCommunication {
  static String _host = "http://192.168.1.18:8080";

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
}