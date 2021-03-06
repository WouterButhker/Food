import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:student/src/communication/database_communication.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/theme/app_localizations.dart';
import 'package:student/src/theme/theme.dart';
import 'package:student/src/widgets/app_drawer.dart';

import 'group_model.dart';

class MainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("welcome")),
      ),
      body: ChangeNotifierProvider(
        create: (context) => GroupModel(),
        child: Container(
          child: Column(
            children: <Widget>[
              ChangeNotifierProvider(
                create: (context) => ThemeButtonState(),
                child: Buttons(),
              ),

              Expanded(
                child: GroupList(),
              ),
            ],
          ),
          margin: EdgeInsets.all(20),
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  int g = 5;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          child: RaisedButton(
            child: Consumer<ThemeButtonState>(
              builder: (context, button, child) {
                return Text(button.buttonText);
              },
            ),
            onPressed: () {
              Provider.of<ThemeState>(context, listen: false).changeTheme();
              Provider.of<ThemeButtonState>(context, listen: false)
                  .changeText();
            },
          ),
        ),
        Container(
          child: RaisedButton(
            child: Text("Add item"),
            onPressed: () {
              //TODO
              Provider.of<GroupModel>(context, listen: false)
                  .addGroup(Group(g, "Group " + g.toString()));
              g++;
              //Navigator.pushNamed(context, '/register');

            },
          ),
          margin: EdgeInsets.all(5),
        ),
//        FutureBuilder<String>(
//          future: ServerCommunication.getAuth(),
//          builder: (context, AsyncSnapshot<String> snapshot) {
//            if (snapshot.hasData) {
//              return Image.network(
//                ServerCommunication.getProfilePictureLink(
//                    "deadlyspammers@gmail.com"),
//                headers: {HttpHeaders.authorizationHeader: snapshot.data},
//                width: 100,
//                height: 100,
//              );
//            } else {
//              return Text("Wait");
//            }
//          },
//        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

class GroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupModel>(builder: (context, groups, child) {
      return ListView.builder(
          itemCount: groups.getGroupNames.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Center(child: Text(groups.getGroupNames[index])),
                onTap: () {
                  Navigator.pushNamed(context, '/food', arguments: groups.getGroups[index]);
                });
            //subtitle: Text("Click " + groups[index] + "!"),);
          });
    });
  }
}

