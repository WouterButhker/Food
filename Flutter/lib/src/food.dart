import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student/src/icons/chef_hat_icons.dart';

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

class People extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[Text("Pieter"), Text("Eeet mee")],
      ),
    );
  }
}

class Choice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {},
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
          shape: CircleBorder(),
          fillColor: Colors.green,
        ),
        RawMaterialButton(
          onPressed: () {},
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
          shape: CircleBorder(),
          fillColor: Colors.red,
        ),
        RawMaterialButton(
          onPressed: () {},
          child: Icon(
            ChefHat.cooking_chef_cap,
            color: Colors.white,
          ),
          shape: CircleBorder(),
          fillColor: Colors.blue,
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
        )
      ],
    );
  }
}
