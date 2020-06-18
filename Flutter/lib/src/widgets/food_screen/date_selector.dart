import 'package:flutter/material.dart';

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