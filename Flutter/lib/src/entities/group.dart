

class Group {

  String _name;
  int _id;

  Group(this._id, this._name);
  Group.onlyName(this._name);

  Group.fromJson(Map<String, dynamic> json)
  : _id = json["id"],
  _name = json["name"];

  Map<String, dynamic> toJson() => {
    'id' : _id,
    'name' : _name
  };

}