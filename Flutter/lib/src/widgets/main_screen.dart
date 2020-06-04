import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/src/theme/AppLocalizations.dart';
import 'package:student/src/theme/theme.dart';

class MainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("welcome")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              SharedPreferences.getInstance().then((pref) {
                Navigator.pushReplacementNamed(context, "/login");
                pref.setBool("loggedIn", false);
              });
              SnackBar snacc = SnackBar(content: Text("Logged out"));
              scaffoldKey.currentState.showSnackBar(snacc);

            },
          )
        ],
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
//              Provider.of<GroupModel>(context, listen: false)
//                  .addGroup("Group " + g.toString());
//              g++;
              Navigator.pushNamed(context, '/register');
            },
          ),
          margin: EdgeInsets.all(5),
        ),
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
          itemCount: groups.groups.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Center(child: Text(groups.groups[index])),
                onTap: () {
                  Navigator.pushNamed(context, '/food');
                });
            //subtitle: Text("Click " + groups[index] + "!"),);
          });
    });
  }
}

class GroupModel extends ChangeNotifier {
  final List<String> _groups = ["Samballen", "test2", "Test99", "Test420"];

  List<String> get groups => _groups;

  void addGroup(String group) {
    _groups.add(group);
    notifyListeners();
  }
}
