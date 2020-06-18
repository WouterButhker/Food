import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/src/controllers/food_controller.dart';
import 'package:student/src/icons/chef_hat_icons.dart';
import 'package:student/src/models/language_model.dart';

class ChoiceButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints.tightFor(height: 40, width: 40),
          onPressed: () {
            FoodController.yes();
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
          constraints: BoxConstraints.tightFor(height: 40, width: 40),
          onPressed: () {
            FoodController.no();
          },
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
          shape: CircleBorder(),
          fillColor: Colors.red,
          elevation: 2,
        ),
        RawMaterialButton(
          constraints: BoxConstraints.tightFor(height: 40, width: 40),
          onPressed: () {
            FoodController.cook();
          },
          child: Icon(
            ChefHat.cooking_chef_cap,
            color: Colors.white,
          ),
          shape: CircleBorder(),
          fillColor: Colors.blue,
          elevation: 2,
        ),
        RawMaterialButton(
          constraints: BoxConstraints.tightFor(height: 40, width: 40),
          onPressed: () {
            FoodController.maybe();
          },
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
          constraints: BoxConstraints.tightFor(height: 40, width: 40),
          onPressed: () {
            // TODO: add popup
            //FoodController.custom(0, 0);
            Provider.of<LanguageModel>(context, listen: false)
                .changeLanguage(Locale('nl'));
          },
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