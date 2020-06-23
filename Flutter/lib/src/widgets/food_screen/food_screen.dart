import 'package:flutter/material.dart';
import 'package:student/src/widgets/food_screen/week_view.dart';

import 'day_summary.dart';
import 'people_list.dart';
import 'choice_buttons.dart';
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
                child: WeekView(),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              ),
            )
          ],
        ));
  }
}






