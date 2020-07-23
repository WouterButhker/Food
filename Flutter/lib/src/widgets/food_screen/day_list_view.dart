import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/src/widgets/food_screen/models/day_model.dart';
import 'package:student/src/widgets/food_screen/models/day_list_model.dart';


class DayListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<DayModel, DayListModel>(
      create: (context) => DayListModel(),
      update: (BuildContext context, DayModel dayModel, DayListModel dayListModel) => dayListModel..update(dayModel, context),
      child: Card(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Consumer<DayListModel>(
            builder: ((context, dayList, child) => GridView.count(
              crossAxisCount: 2,
              children: dayList.tiles,
              childAspectRatio: 6,
            )),
          ),

        ),
      ),
    );
  }

  List<GridTile> _peopleList(List<String> _people) {
    List<GridTile> out = new List();
    for (String s in _people) {
      out.add(
        GridTile(
          child: Align(
            child: Text(s),
            alignment: Alignment.centerLeft,
          ),
        ),
      );
      out.add(
        GridTile(
          child: Align(
            child: Text(
              "Eet mee",

            ),
            alignment: Alignment.centerLeft,
          ),
        ),
      );
    }
    return out;
  }
}