import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/widgets/food_screen/reservations_model.dart';

class DaySummary extends StatelessWidget {
  final Group userGroup;

  DaySummary(this.userGroup);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Consumer<DaySummaryModel>(
          builder: (context, model, child) => Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: Provider.of<ReservationModel>(context)
                                .getEatingAt(
                                    DateTime.now().add(Duration(days: 1)))
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          TextSpan(text: " eten wel mee"),
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
                            text: Provider.of<DaySummaryModel>(context, listen: false).selectedDate.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          TextSpan(text: " eten niet mee"),
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
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Wouter",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          TextSpan(text: " kookt"),
                        ],
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
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
                            text: "5",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          TextSpan(text: " hebben niet gereageerd"),
                        ],
                        style: TextStyle(
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ],
          ),
        ),
        margin: EdgeInsets.all(20),
      ),
      //margin: EdgeInsets.all(20),
    );
  }
}

class DaySummaryModel extends ChangeNotifier {
  DateTime selectedDate;

  DaySummaryModel(this.selectedDate);

  void goToNextDay() {
    selectedDate = selectedDate.add(Duration(days: 1));
    notifyListeners();
  }

  void goToPreviousDay() {
    selectedDate = selectedDate.subtract(Duration(days: 1));
    notifyListeners();
  }

  void goToSpecificDay(DateTime date) {
    if (date == null) return;
    selectedDate = date;
    notifyListeners();
  }

  get getSelectedDate => selectedDate;
}
