

import 'package:flutter/material.dart';
import 'package:student/src/theme/app_localizations.dart';
import 'package:student/src/widgets/app_drawer.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("account")),
      ),
      body: ListView(
        children: <Widget>[

        ],
      ),
    );
  }
}
