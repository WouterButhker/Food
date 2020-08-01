import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/src/entities/reservation.dart';
import 'package:student/src/entities/user.dart';
import 'package:student/src/theme/app_localizations.dart';
import 'package:student/src/widgets/food_screen/models/day_model.dart';

class DayListModel extends ChangeNotifier {
  DayModel _dayModel;
  List<GridTile> tiles = [];

  void update(DayModel dayModel, BuildContext context) {
    tiles = [];
    _dayModel = dayModel;
    List<User> users = dayModel.usersInGroup;
    users.sort();
    //final prefs = await SharedPreferences.getInstance();
    //int userId = prefs.getInt("userId");

    for (User u in users) {
      tiles.add(GridTile(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(u.name,
          style: TextStyle(
            // TODO bold own user
//            fontWeight: u.id == userId ? FontWeight.bold : FontWeight.normal,
          ),),
        ),
      ));

      Color textColor = Colors.orange;
      String text = AppLocalizations.of(context).translate("no_response");
      for (Reservation res in _dayModel.reservationsForDay) {
        if (u.id == res.user) {
          if (res.amountEating == 0) {
            text = AppLocalizations.of(context).translate("not_eating");
            textColor = Colors.red;
            break;
          } else if (res.amountEating == 1 && !res.isCooking) {
            text = AppLocalizations.of(context).translate("eating");
            textColor = Colors.green;
            break;
          } else if (res.amountEating == 1 && res.isCooking) {
            text = AppLocalizations.of(context).translate("cooking");
            textColor = Colors.blue;
            break;
          } else if (res.amountEating > 1 && !res.isCooking) {
            text = AppLocalizations.of(context).translate("eating") +
                " " +
                res.amountEating.toString() +
                "x";
            textColor = Colors.green;
            break;
          } else if (res.amountEating > 1 && res.isCooking) {
            text = AppLocalizations.of(context).translate("cooking") +
                ", " +
                AppLocalizations.of(context).translate("eating") +
                " " + res.amountEating.toString() +
                "x";
            textColor = Colors.blue;
            break;
          }
        }
      }

      tiles.add(GridTile(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
    }

    notifyListeners();
  }
}
