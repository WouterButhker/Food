import 'package:flutter/cupertino.dart';
import 'package:student/src/theme/app_localizations.dart';

import '';
import 'package:student/src/controllers/date_only_compare.dart';
import 'package:intl/intl.dart';

class LanguageHelper {

  static String dayViewDate(DateTime date, BuildContext context) {
    //print('LanguageHelper.dayViewDate');
    DateFormat dateFormat = DateFormat.MMMd(AppLocalizations.of(context).locale.toString());
    if (date.isSameDate(DateTime.now())) {
        return AppLocalizations.of(context).translate("today") + " " +  dateFormat.format(date);
    } else if (date.isSameDate(DateTime.now().add(Duration(days: 1)))) {
      return AppLocalizations.of(context).translate("tomorrow") + " " +  dateFormat.format(date);
    } else if (date.isSameDate(DateTime.now().subtract(Duration(days: 1)))) {
      return AppLocalizations.of(context).translate("yesterday") + " " +  dateFormat.format(date);
    }
    return DateFormat.MMMEd(AppLocalizations.of(context).locale.toString()).format(date);

  }
}

