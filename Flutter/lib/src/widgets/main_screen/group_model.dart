import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:student/src/communication/database_communication.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/entities/group.dart';

class GroupModel extends ChangeNotifier {
  List<Group> _groups = [];

  GroupModel() {
    print("INIT GROUPMODEL");
    init();
  }

  void init() async {
//    List<Group> dbGroups = await _getGroupsFromLocal();
//
//    _groupNames = dbGroups.map((group) => group.name).toList();
//    notifyListeners();
//    print("Set groups from db");

    _groups = await _getGroupsFromServer();

//    if (!dbGroups.toSet().containsAll(serverGroups.toSet())) {
//      print("Groups from db are not the same as from server, updating db");
    notifyListeners();
//
//      //print("res.body: " + res.body);
////      List jsonList = json.decode(res.body);
//      //print("json: " + jsonObj.toString());
//      DatabaseCommunication.addAllGroups(serverGroups);
//    }
  }

  Future<List<Group>> _getGroupsFromLocal() async {
    List<Group> dbGroups = await DatabaseCommunication.getAllGroupsFromUser();

    return dbGroups;
  }

  Future<List<Group>> _getGroupsFromServer() async {
    Response res = await ServerCommunication.getUserGroups();
    List<Group> serverGroups;
    if (res.statusCode == 200) serverGroups = Group.getListFromJson(res.body);
    return serverGroups;
  }

  List<String> get getGroupNames => _groups.map((group) => group.name).toList();

  List<Group> get getGroups => this._groups;

  void addGroup(Group group) {
    _groups.add(group);
    notifyListeners();
  }
}
