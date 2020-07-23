import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/widgets/food_screen/models/day_model.dart';


import 'models/date_selection_model.dart';
import 'models/day_summary_model.dart';
import 'models/reservations_model.dart';

class DaySummary extends StatelessWidget {
  final Group userGroup;

  DaySummary(this.userGroup);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ChangeNotifierProxyProvider<DayModel,
          DaySummaryModel>(
        create: (context) => DaySummaryModel(),
        update: (BuildContext context,
                DayModel dayModel,
                DaySummaryModel daySummaryModel) =>
            daySummaryModel..update(dayModel),
        child: Container(
          margin: EdgeInsets.all(20),
          child: Consumer<DaySummaryModel>(
            builder: (context, summaryData, child) => Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: summaryData.eating.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            TextSpan(text: summaryData.eatingText.toString()),
                          ],
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: summaryData.notEating.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            TextSpan(text: summaryData.notEatingText),
                          ],
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: summaryData.cook,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            TextSpan(text: summaryData.cookText),
                          ],
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: summaryData.notResponded.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            TextSpan(text: summaryData.notRespondedText),
                          ],
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //margin: EdgeInsets.all(20),
  }
}



