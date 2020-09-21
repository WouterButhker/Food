import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NetworkException implements Exception {
  String _message;
  Response _res;

  NetworkException({Response response, String message = "Network error"}) {
    this._message = message;
    this._res = response;

    if (_res != null) {
      Map<String, dynamic> jsonResponse = json.decode(_res.body);
      this._message = "Network error " + _res.statusCode.toString() + ": " + jsonResponse["message"];
    }
  }


  void showErrorSnackbar(BuildContext context) {
    if (context == null) {
      print("No context supplied, cannot show network error to user");
      return;
    }

    final snackBar = SnackBar(
      content: Text(_message),
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


}
