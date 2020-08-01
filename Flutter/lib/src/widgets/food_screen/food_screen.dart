import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/widgets/food_screen/animation.dart';
import 'package:student/src/widgets/food_screen/week_view.dart';
import 'day_summary.dart';
import 'day_list_view.dart';
import 'choice_buttons.dart';
import 'date_selector.dart';
import 'models/date_selection_model.dart';
import 'models/reservations_model.dart';
import 'package:student/src/widgets/food_screen/models/day_model.dart';
import 'models/dayOrWeekModel.dart';

class FoodScreen extends StatelessWidget {
  final Group userGroup;

  FoodScreen(this.userGroup);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ReservationModel(this.userGroup)),
        ChangeNotifierProvider(
          create: (context) => DateSelectionModel(DateTime.now()),
        ),
        ChangeNotifierProvider(
          create: (context) => DayOrWeekModel(),
        ),
        ChangeNotifierProxyProvider2<ReservationModel, DateSelectionModel,
            DayModel>(
          create: (context) => DayModel(),
          update: (BuildContext context, ReservationModel reservationModel,
                  DateSelectionModel dateSelectionModel, DayModel dayModel) =>
              dayModel..update(dateSelectionModel, reservationModel),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.userGroup.name),
          actions: <Widget>[
            Consumer<DayOrWeekModel>(
              builder: (context, dayOrWeekModel, child) => IconButton(
                onPressed: () {
                  dayOrWeekModel.changeView();
                },
                icon: Icon(Icons.calendar_today),
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: DateSelector(),
              margin: EdgeInsets.all(10),
            ),
            ChoiceButtons(group: this.userGroup),
            Container(
              child: Consumer<DayOrWeekModel>(
                builder: (context, dayOrWeekModel, child) =>
                    dayOrWeekModel.dayView
                        ? MyAnimationWidget(this.userGroup)
                        : SizedBox.shrink(),
              ),
              margin: EdgeInsets.all(20),
            ),
            Expanded(
              child: Container(
                child: Consumer<DayOrWeekModel>(
                  builder: (context, dayOrWeekModel, child) =>
                      dayOrWeekModel.dayView ? DayListView() : WeekView(),
                ),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
