import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/widgets/food_screen/reservations_model.dart';
import 'package:student/src/widgets/food_screen/week_view.dart';

import 'day_summary.dart';
import 'day_view.dart';
import 'choice_buttons.dart';
import 'date_selector.dart';

class FoodScreen extends StatelessWidget {
  final Group userGroup;

  FoodScreen(this.userGroup);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.userGroup.name),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ReservationModel(this.userGroup)),
          ChangeNotifierProvider(create: (context) => DateSelectionModel(DateTime.now()),)
        ],
        child: Column(
          children: <Widget>[
            Container(
              child: DateSelector(),
              margin: EdgeInsets.all(10),
            ),
            ChoiceButtons(group: this.userGroup),
            Container(
              child: DaySummary(this.userGroup),
              margin: EdgeInsets.all(20),
            ),
            Expanded(
              child: Container(
                child: DayView(),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}






