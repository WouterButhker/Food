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
            Expanded(
              child: Container(
                child: Selector(),
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              ),
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
      child: GridView.count(
        crossAxisCount: 2,

        children: <Widget>[
          Text("Pieter"),
          Text("Eeet mee")
        ],
      ),
    );
  }
}
