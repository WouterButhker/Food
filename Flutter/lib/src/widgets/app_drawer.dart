import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student/src/controllers/account_controller.dart';
import 'package:student/src/controllers/login_controller.dart';
import 'package:student/src/theme/app_localizations.dart';

// TODO: instead of pushReplacementNamed use a single scaffold and replace the child
// TODO: and add an animation
// https://stackoverflow.com/questions/43680902/replace-initial-route-in-materialapp-without-animation
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text("email@mail.com"),
            accountName: Text("Wouter"),
            onDetailsPressed: () {},
            currentAccountPicture: Material(
              color: Theme.of(context).accentColor,
              shape: CircleBorder(side: BorderSide(width: 0)),
              child: ChangeNotifierProvider(
                create: (context) => _ImageModel(),
                child: Consumer<_ImageModel>(
                    builder: (context, imageModel, child) {
                  return InkWell(
                    customBorder: CircleBorder(),
                    onTap: () {
                      imageModel.setImage();
                    },
                    child: CircleAvatar(
                      backgroundImage: imageModel.image != null ? FileImage(imageModel.image) : null,
                      child: imageModel.image == null ? Text("a") : null,
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }),
              ),
            ),
            otherAccountsPictures: <Widget>[
              RawMaterialButton(
                shape: CircleBorder(),
                fillColor: Theme.of(context).accentColor,
                child: Icon(Icons.exit_to_app),
                onPressed: () {
                  LoginController.logout(context);
                },
              ),
            ],
          ),
          ListTile(
            title: Text("main"),
            onTap: () {
              //Future.delayed(Duration(milliseconds: 250)).then((value) => Navigator.pushReplacementNamed(context, "/main"));
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, "/main");
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate("account")),
            leading: Icon(Icons.account_circle),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate("settings")),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, "/settings");
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate("about")),
            leading: Icon(Icons.info),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ImageModel extends ChangeNotifier {
  File _image;

  _ImageModel() {
    // TODO: get image from storage or whatever
  }

  void setImage() async {
    File file = await AccountController.pickImage(ImageSource.gallery);

    if (file == null) return;

    _image = file;
    notifyListeners();
  }

  File get image => _image;
}
