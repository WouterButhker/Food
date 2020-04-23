import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/src/food.dart';
import 'package:student/src/login.dart';
import 'package:student/src/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeModel(),
        child: Consumer<ThemeModel>(builder: (context, theme, child) {
          return MaterialApp(
              title: 'Student tools',
              initialRoute: '/main',
              routes: {
                '/login': (context) => Login(),
                '/main': (context) => MainScreen(),
                '/food': (context) => Food(),
              },
              theme: theme.theme);
        }));
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HALLO"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => GroupModel(),
        child: Container(
          child: Column(
            children: <Widget>[
              ChangeNotifierProvider(
                  create: (context) => ThemeButtonModel(),
                  child: Buttons()),
              Expanded(child: GroupList()),
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
            child: Consumer<ThemeButtonModel>(builder: (context, button, child) {
              return Text(button.buttonText);
            },),
            onPressed: () {
              Provider.of<ThemeModel>(context, listen: false).changeTheme();
              Provider.of<ThemeButtonModel>(context, listen: false).changeText();
            },
          ),
        ),
        Container(
          child: RaisedButton(
            child: Text("Add item"),
            onPressed: () {
              //TODO
              Provider.of<GroupModel>(context, listen: false)
                  .addGroup("Group " + g.toString());
              g++;
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
  final List<String> _groups = ["test", "test2", "Test99", "Test420"];

  List<String> get groups => _groups;

  void addGroup(String group) {
    _groups.add(group);
    notifyListeners();
  }
}