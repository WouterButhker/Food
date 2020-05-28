import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:student/src/controllers/login_controller.dart';
import 'package:student/src/widgets/checkbox_list_tile_form_field.dart';
import 'package:student/src/widgets/password_bar.dart';

class Register extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Form(
            key: _formKey,
            child: ChangeNotifierProvider(
              create: (context) => _RegisterScreenModel(),
              child: _RegisterScreen(_formKey),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _RegisterScreen extends StatelessWidget {
  final FocusNode _emailNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _passNode = FocusNode();
  final FocusNode _pass2Node = new FocusNode();
  GlobalKey<FormState> _formKey;

  String _email;
  String _name;
  String _pass;
  bool _marketingMails;

  _RegisterScreen(this._formKey);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text("Welcome"),
        _emailInput(context),
        _nameInput(context),
        _passInput(context),
        _passwordBar(context),
        _passInput2(context),
        acceptTerms(context),
        marketing(context),
        RaisedButton(
            child: Text("Register account"),
            onPressed: () {
              _formKey.currentState.save();
              if (_formKey.currentState.validate()) {
                LoginController.register(_email, _name, _pass,
                    _marketingMails, context);
              }
            }),
      ],
    );
  }

  Widget _emailInput(context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Email address*", alignLabelWithHint: true),
      validator: LoginController.validateEmail,
      textInputAction: TextInputAction.next,
      focusNode: _emailNode,
      onFieldSubmitted: (term) {
        _emailNode.unfocus();
        FocusScope.of(context).requestFocus(_nameNode);
      },
      keyboardType: TextInputType.emailAddress,
      onSaved: (String val) {
        _email = val;
      },
    );
  }

  Widget _nameInput(context) {
    return TextFormField(
      decoration: InputDecoration(labelText: "Name*", alignLabelWithHint: true),
      focusNode: _nameNode,
      onFieldSubmitted: (term) {
        _nameNode.unfocus();
        FocusScope.of(context).requestFocus(_passNode);
      },
      keyboardType: TextInputType.text,
      onSaved: (String val) {
        _name = val;
      },
      validator: (val) {
        if (val.isEmpty) return "Please enter your name";
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget _passInput(context) {
    return TextFormField(
      obscureText: true,
      decoration:
          InputDecoration(labelText: "Password*", alignLabelWithHint: true),
      autocorrect: false,
      focusNode: _passNode,
      onChanged: (val) {
        Provider.of<_RegisterScreenModel>(context, listen: false)
            .setPassword(val);
        Provider.of<_RegisterScreenModel>(context, listen: false).showBar();
      },
      validator: LoginController.checkPasswordStrength,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (val) {
        _passNode.unfocus();
        FocusScope.of(context).requestFocus(_pass2Node);
      },
      onSaved: (val) {
        _pass = val;
      },
    );
  }

  Widget _passInput2(context) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Retype password*", alignLabelWithHint: true),
      autocorrect: false,
      focusNode: _pass2Node,
      validator: (password2) {
        return LoginController.checkPasswordsMatch(_pass, password2);
      },
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (term) {},
      onSaved: (val) {},
    );
  }

  Widget _passwordBar(context) {
    return Consumer<_RegisterScreenModel>(
        builder: (context, passwordBarModel, child) {
          return Visibility(
            visible: passwordBarModel._show,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: PasswordBar(
                password: passwordBarModel._password,
                radius: 5,
                height: 5,
                backgroundColor: Theme
                    .of(context)
                    .backgroundColor,
              ),
            ),
          );
        });
  }

  Widget acceptTerms(context) {
    return CheckboxListTileFormField(
      context: context,
      title: Text("I have read the terms and conditions"
          " and I agree to the privacy policiy*"),
      // TODO: add privacy policy and terms
      validator: (val) {
        if (!val) return "Accepting the terms is required";
        return null;
      },
    );
  }

  Widget marketing(context) {
    return CheckboxListTileFormField(
      context: context,
      title: Text("I want to receive marketing emails"),
      dense: false,
      onSaved: (val) {
        _marketingMails = val;
      }
    );
  }
}

class _RegisterScreenModel extends ChangeNotifier {
  String _password;
  bool _show = false;

  void setPassword(String pass) {
    _password = pass;
    notifyListeners();
  }

  void showBar() {
    if (_show) return;
    _show = true;
    notifyListeners();
  }

}
