import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passNode = FocusNode();

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
                      })
                ],
              ),
            ),
          ),
        ));
  }

  void _login(context) {
    if (_formKey.currentState.validate()) {
      //TODO
      Navigator.pushReplacementNamed(context, "/main");
    }
  }

  String _validateEmail(String email) {
    // according to HTML5 spec
    String _emailPattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

    if (email.isEmpty) {
      return "Please enter an email address";
    }
    if (RegExp(_emailPattern).hasMatch(email)) return null;

    return "Incorrect email address";
  }

  Widget _emailInput(context) {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Email address", alignLabelWithHint: true),
      validator: _validateEmail,
      textInputAction: TextInputAction.next,
      focusNode: _emailNode,
      onFieldSubmitted: (term) {
        _emailNode.unfocus();
        FocusScope.of(context).requestFocus(_passNode);
      },
      keyboardType: TextInputType.emailAddress,
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
    );
  }
}
