import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:student/src/communication/database_communication.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/controllers/food_controller.dart';
import 'package:student/src/entities/user.dart';
import 'package:student/src/icons/chef_hat_icons.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/models/language_model.dart';
import 'package:student/src/theme/app_localizations.dart';
import 'package:student/src/widgets/food_screen/day_summary.dart';
import 'package:student/src/widgets/food_screen/peopleList.dart';

import 'choiceButtons.dart';
import 'date_selector.dart';

class FoodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Eten"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: DateSelector(),
              margin: EdgeInsets.all(10),
            ),
            ChoiceButtons(),
            Container(
              child: DaySummary(),
              margin: EdgeInsets.all(20),
            ),
            Expanded(
              child: Container(
                child: PeopleList(),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              ),
            )
          ],
        ));
  }
}






