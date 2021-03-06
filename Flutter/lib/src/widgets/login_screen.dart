import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passNode = FocusNode();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Container(
          margin: EdgeInsets.all(50),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Login",
                    textScaleFactor: 3,
                  ),
                  _emailInput(context),
                  _passInput(context),
                  RaisedButton(
                      child: Text("Login"),
                      onPressed: () {
                        _login(context);
                      }),
                  RaisedButton(
                    child: Text("Register"),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/register");
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _login(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      LoginController.login(_email, _password);

      // TODO: only go to main if login is successful
      Navigator.pushReplacementNamed(context, "/main");
    }
  }

  Widget _emailInput(context) {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Email address", alignLabelWithHint: true),
      validator: (email) {
        if (email.isEmpty) {
          return "Please enter an email";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      focusNode: _emailNode,
      onFieldSubmitted: (term) {
        _emailNode.unfocus();
        FocusScope.of(context).requestFocus(_passNode);
      },
      keyboardType: TextInputType.emailAddress,
      onSaved: (String val) {
        _email = val;
      },
    );
  }

  Widget _passInput(context) {
    return TextFormField(
      obscureText: true,
      decoration:
          InputDecoration(labelText: "Password", alignLabelWithHint: true),
      autocorrect: false,
      focusNode: _passNode,
      validator: (password) {
        if (password.isEmpty) {
          return "Please enter a password";
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (term) {
        _login(context);
      },
      onSaved: (val) {
        _password = val;
      },
    );
  }
}
