import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:student/src/controllers/food_controller.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/icons/chef_hat_icons.dart';
import 'package:student/src/models/language_model.dart';
import 'package:student/src/widgets/checkbox_list_tile_form_field.dart';
import 'package:student/src/widgets/food_screen/day_summary.dart';
import 'package:student/src/widgets/food_screen/models/day_model.dart';

import 'models/date_selection_model.dart';

class ChoiceButtons extends StatelessWidget {
  final Group group;

  const ChoiceButtons({Key key, this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints.tightFor(height: 40, width: 40),
          onPressed: () {
            FoodController.yes(
              Provider.of<DateSelectionModel>(context, listen: false)
                  .selectedDate,
              group,
              context,
            );
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
            FoodController.no(
              Provider.of<DateSelectionModel>(context, listen: false)
                  .selectedDate,
              group,
              context,
            );
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
            FoodController.cook(
              Provider.of<DateSelectionModel>(context, listen: false)
                  .selectedDate,
              group,
              context,
            );
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
            FoodController.maybe(
              Provider.of<DateSelectionModel>(context, listen: false)
                  .selectedDate,
              group,
              context,
            );
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
            showDialog(
                context: context,
                builder: CustomChoiceDialog(this.group, context).build);
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

// ignore: must_be_immutable
class CustomChoiceDialog extends StatelessWidget {
  final FocusNode _userSelectionFocusNode = FocusNode();
  final FocusNode _amountEatingFocusNode = FocusNode();
  final FocusNode _isCookingFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Group _group;
  final BuildContext _parentContext;

  CustomChoiceDialog(this._group, this._parentContext);

  int user;
  bool isCooking = false;
  int amountEating = 1;
  String notes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Title"),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Confirm"),
          onPressed: () {
            _formKey.currentState.save();
            FoodController.custom(
              Provider.of<DayModel>(context, listen: false)
                  .dateSelectionModel
                  .selectedDate,
              _group,
              context,
            );
          },
        ),
      ],
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButtonFormField(
              onChanged: (val) {
                user = val;
              },
              items: Provider.of<DayModel>(_parentContext, listen: false)
                  .usersInGroup
                  .map((user) => DropdownMenuItem(
                        value: user.id,
                        child: Text(user.name),
                      ))
                  .toList(),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              focusNode: _amountEatingFocusNode,
              onChanged: (val) {
                amountEating = int.parse(val);
              },
              onTap: () {},
              onSaved: (val) {},
              initialValue: "1",
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            ),
            CheckboxListTileFormField(
              context: context,
              onSaved: (val) {
                isCooking = val;
              },
              title: Text("Is cooking"),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (val) {
                notes = val;
              },
            )
          ],
        ),
      ),
    );
  }
}

