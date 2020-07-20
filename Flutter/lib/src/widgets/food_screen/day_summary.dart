import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/widgets/food_screen/reservations_model.dart';
import 'package:student/src/controllers/date_only_compare.dart';

class DaySummary extends StatelessWidget {
  final Group userGroup;

  DaySummary(this.userGroup);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ChangeNotifierProxyProvider2<ReservationModel, DateSelectionModel,
          DaySummaryModel>(
        create: (context) => DaySummaryModel(),
        update: (BuildContext context,
                ReservationModel reservationModel,
                DateSelectionModel dateSelectionModel,
                DaySummaryModel daySummaryModel) =>
            daySummaryModel..update(dateSelectionModel, reservationModel),
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

class DaySummaryModel with ChangeNotifier {
  DateSelectionModel _dateSelectionModel;
  ReservationModel _reservationModel;

  int eating = 0;
  int notEating = 0;
  int notResponded = 0;
  String cook = "?";

  // TODO: get values from language helper
  String eatingText = " Eten mee";
  String notEatingText = " Eten niet mee";
  String notRespondedText = " Hebben niet gereageerd";
  String cookText = " Kookt";

  DaySummaryModel(){
    init();
  }

  void init() {
    this.eating = 0;
    this.notEating = 0;
    this.notResponded = 0;
    this.cook = "?";
  }

  void update(DateSelectionModel dateSelectionModel,
      ReservationModel reservationModel) {

    init();
    this._dateSelectionModel = dateSelectionModel;
    this._reservationModel = reservationModel;

    for (Reservation res in this._reservationModel.reservations) {
      if (res.date.isSameDate(_dateSelectionModel.selectedDate)) {
        if (res.amountEating != 0) {
          eating += res.amountEating;
        } else {
          notEating++;
        }
        // TODO: get notResponded number
        if (res.isCooking) {
          // TODO: get user name
          cook = res.user.toString();
        }
      }
    }

    notifyListeners();
  }
}

class DateSelectionModel extends ChangeNotifier {
  DateTime selectedDate;

  DateSelectionModel(this.selectedDate);

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
