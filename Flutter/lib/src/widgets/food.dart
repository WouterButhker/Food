import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/icons/chef_hat_icons.dart';
import 'package:student/src/logic/reservation.dart';

class Food extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Eten"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: DateSelector(),
              margin: EdgeInsets.all(10),
            ),
            Choice(),
            Expanded(
              child: Container(
                child: People(),
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
              child: RawMaterialButton(
                child: Icon(Icons.chevron_left),
                onPressed: () {},
              ),
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
              child: RawMaterialButton(
                child: Icon(Icons.chevron_right),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  void _getDate() {
    DateTime _today = DateTime.now();

  }
}

class People extends StatelessWidget {
  List<String> _people = ["Wouter", "Pieter", "Klaas", "Adam"];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          children: _peopleList(_people),
          childAspectRatio: 6,
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
            child: Text(
              s
            ),
            alignment: Alignment.centerLeft,
          ),
        ),
      );
      out.add(
        GridTile(
          child: Align(
            child: Text(
              "Eet mee",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            alignment: Alignment.center,
          ),
        ),
      );
    }
    return out;
  }
}

class Choice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            Reservation _res = Reservation("Samballen", DateTime.now(), 1,  amountEating: 1);
            String _json = jsonEncode(_res);
            print(_json);
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
          onPressed: () {},
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
          shape: CircleBorder(),
          fillColor: Colors.red,
          elevation: 2,
        ),
        RawMaterialButton(
          onPressed: () {},
          child: Icon(
            ChefHat.cooking_chef_cap,
            color: Colors.white,
          ),
          shape: CircleBorder(),
          fillColor: Colors.blue,
          elevation: 2,
        ),
        RawMaterialButton(
          onPressed: () {},
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
          onPressed: () {},
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
}
