import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:student/src/controllers/food_controller.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/icons/chef_hat_icons.dart';
import 'package:student/src/models/language_model.dart';
import 'package:student/src/widgets/food_screen/day_summary.dart';

import 'models/date_selection_model.dart';

class ChoiceButtons extends StatelessWidget {
  final Group group;

  const ChoiceButtons({Key key, this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints.tightFor(height: 40, width: 40),
          onPressed: () {
            FoodController.yes(
                Provider.of<DateSelectionModel>(context, listen: false)
                    .selectedDate,
                group);
          },
          // alone
          onLongPress: () {},
          // more people
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
          shape: CircleBorder(),
          fillColor: Colors.green,
          elevation: 2,
        ),
        RawMaterialButton(
          constraints: BoxConstraints.tightFor(height: 40, width: 40),
          onPressed: () {
            FoodController.no(
                Provider.of<DateSelectionModel>(context, listen: false)
                    .selectedDate,
                group);
          },
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
          shape: CircleBorder(),
          fillColor: Colors.red,
          elevation: 2,
        ),
        RawMaterialButton(
          constraints: BoxConstraints.tightFor(height: 40, width: 40),
          onPressed: () {
            FoodController.cook(
                Provider.of<DateSelectionModel>(context, listen: false)
                    .selectedDate,
                group);
          },
          child: Icon(
            ChefHat.cooking_chef_cap,
            color: Colors.white,
          ),
          shape: CircleBorder(),
          fillColor: Colors.blue,
          elevation: 2,
        ),
        RawMaterialButton(
          constraints: BoxConstraints.tightFor(height: 40, width: 40),
          onPressed: () {
            FoodController.maybe(
                Provider.of<DateSelectionModel>(context, listen: false)
                    .selectedDate,
                group);
          },
          child: Text(
            "?",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textScaleFactor: 1.4,
          ),
          shape: CircleBorder(),
          fillColor: Colors.orange,
          elevation: 2,
        ),
        RawMaterialButton(
          constraints: BoxConstraints.tightFor(height: 40, width: 40),
          onPressed: () {
            // TODO: add popup
//            FoodController.custom(
//                Provider.of<DateSelectionModel>(context, listen: false)
//                    .selectedDate,
//                group,
//                amountEating: 5);
          _customDialog(context);
          },
          child: Text(
            "...",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          shape: CircleBorder(),
          fillColor: Colors.grey,
          elevation: 2,
        )
      ],
    );
  }

  Future _customDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Title"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Cooking?"),
                  Text("Amount?"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Confirm"),
                onPressed: () {},
              ),
            ],
          );
        });
  }
}
