import 'package:flutter/material.dart';

class DayView extends StatelessWidget {
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
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
        ),
      );
    }
    return out;
  }
}