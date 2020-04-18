import 'package:flutter/material.dart';

class Food extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("HALLO"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: DateSelector(),
              margin: EdgeInsets.all(10),
            ),
            Container(
              child: Selector(),
              margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
            )
          ],
        ));
  }
}

class DateSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Expanded(
            child: Center(
              child: Icon(Icons.chevron_left),
            ),
          ),
        ),
        Center(
            child: Text(
          "Vandaag",
          textScaleFactor: 3,
        )),
        Container(
          child: Expanded(
            child: Center(
              child: Icon(Icons.chevron_right),
            ),
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

class Selector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Center(
            child: Text("MMMMMM"),
          ),
          Grid
        ],
      ),
    );
  }
}
