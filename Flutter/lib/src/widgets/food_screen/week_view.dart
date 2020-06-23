import 'package:flutter/material.dart';

class WeekView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(20),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 16,
          ),
          child: Table(
            //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              horizontalInside: BorderSide(),
              verticalInside: BorderSide(),
            ),
            columnWidths: {0: FractionColumnWidth(0.4)},
            children: [
              TableRow(children: [
                SizedBox.shrink(),
                Center(child: Text("M")),
                Center(child: Text("D")),
                Center(child: Text("W")),
                Center(child: Text("D")),
                Center(child: Text("V")),
                Center(child: Text("Z")),
                Center(child: Text("Z")),
              ]),
              TableRow(children: [
                Text("Ik"),
                Center(child: Text("V")),
                Center(child: Text("X")),
                Center(child: Text("V")),
                Center(child: Text("C")),
                Center(child: Text("V")),
                Center(child: Text("?")),
                Center(child: Text("V")),
              ]),
              TableRow(children: [
                Text("Aantal eet"),
                Center(child: Text("1")),
                Center(child: Text("2")),
                Center(child: Text("4")),
                Center(child: Text("5")),
                Center(child: Text("0")),
                Center(child: Text("1")),
                Center(child: Text("1")),
              ]),
              TableRow(children: [
                Text("Aantal eet niet"),
                Center(child: Text("1")),
                Center(child: Text("2")),
                Center(child: Text("4")),
                Center(child: Text("5")),
                Center(child: Text("0")),
                Center(child: Text("1")),
                Center(child: Text("1")),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget daysOfTheWeek() {
    return Row(
      children: <Widget>[],
    );
  }
}
