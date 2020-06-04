import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student/src/theme/app_localizations.dart';


// TODO: instead of pushReplacementNamed use a single scaffold and replace the child
// TODO: and add an animation
// https://stackoverflow.com/questions/43680902/replace-initial-route-in-materialapp-without-animation
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("main"),
            onTap: () {
              //Future.delayed(Duration(milliseconds: 250)).then((value) => Navigator.pushReplacementNamed(context, "/main"));
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, "/main");
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate("account")),
            leading: Icon(Icons.account_circle),
            onTap: () {},
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate("settings")),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, "/settings");
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate("about")),
            leading: Icon(Icons.info),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
