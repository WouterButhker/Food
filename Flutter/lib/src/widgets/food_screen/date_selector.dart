import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/src/controllers/language_helper.dart';
import 'package:student/src/widgets/food_screen/day_summary.dart';

import 'models/date_selection_model.dart';

class DateSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 50,
          child: FlatButton(
//            color: Colors.orange,

            child: Icon(Icons.chevron_left),
            onPressed: () {
              Provider.of<DateSelectionModel>(context, listen: false)
                  .goToPrevious();
              Provider.of<DateSelectionModel>(context, listen: false)
                  .animationController
                  .reverse();
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
                  .goToSpecific(value);
            });
          },
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              Provider.of<DateSelectionModel>(context).dayView
                  ? LanguageHelper.dayViewDate(
                      Provider.of<DateSelectionModel>(context).selectedDate,
                      context)
                  : LanguageHelper.weekViewDate(
                      Provider.of<DateSelectionModel>(context).selectedDate,
                      context),
              textScaleFactor: 2.3,
            ),
          ),
        )),
        Container(
          child: RawMaterialButton(
            child: Icon(Icons.chevron_right),
            onPressed: () {
              Provider.of<DateSelectionModel>(context, listen: false)
                  .goToNext();
              Provider.of<DateSelectionModel>(context, listen: false)
                  .animationController
                  .forward();
            },
          ),
        ),
      ],
    );
  }
}
