import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/src/controllers/language_helper.dart';
import 'package:student/src/widgets/food_screen/day_summary.dart';

class DateSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: RawMaterialButton(
            child: Icon(Icons.chevron_left),
            onPressed: () {
              Provider.of<DateSelectionModel>(context, listen: false)
                  .goToPreviousDay();
            },
          ),
        ),
        Center(
            child: GestureDetector(
          onTap: () {
            // TODO: select logical first and last dates
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now().add(Duration(days: 30)))
                .then((value) {
              Provider.of<DateSelectionModel>(context, listen: false)
                  .goToSpecificDay(value);
            });
          },
          child: Text(
            LanguageHelper.dayViewDate(
                Provider.of<DateSelectionModel>(context).selectedDate, context),
            textScaleFactor: 2.4,
          ),
        )),
        Container(
          child: RawMaterialButton(
            child: Icon(Icons.chevron_right),
            onPressed: () {
              Provider.of<DateSelectionModel>(context, listen: false)
                  .goToNextDay();
            },
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
