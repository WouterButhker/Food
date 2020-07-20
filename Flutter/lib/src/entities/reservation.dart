import 'package:json_annotation/json_annotation.dart';
import 'package:student/src/entities/database_item.dart';
import 'package:student/src/controllers/date_only_compare.dart';

@JsonSerializable()
class Reservation extends DatabaseItem implements Comparable<Reservation> {
  DateTime _date;
  int _groupId;
  int _amountEating;
  bool _isCooking;
  int _user;

  Reservation(int group, DateTime date, int user,
      {int amountEating = 0, bool isCooking = false}) {
    _user = user;
    _groupId = group;
    _date = date;
    _isCooking = isCooking;
    _amountEating = amountEating;
  }

  Reservation.fromJson(Map<String, dynamic> json)
      : _date = DateTime.parse(json['date']),
        _groupId = json['groupId'],
        _amountEating = json['amountEating'],
        _isCooking = json['isCooking'],
        _user = json['userId'];

  Map<String, dynamic> toJson() => {
        'date': _date.toIso8601String(),
        'groupId': _groupId,
        'amountEating': _amountEating,
        'isCooking': _isCooking,
        'userId': _user
      };

  int get user => _user;

  set user(int value) {
    _user = value;
  }

  bool get amountCooking => _isCooking;

  set amountCooking(bool value) {
    _isCooking = value;
  }

  int get amountEating => _amountEating;

  set amountEating(int value) {
    _amountEating = value;
  }

  int get group => _groupId;

  set group(int value) {
    _groupId = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Reservation &&
          runtimeType == other.runtimeType &&
          _date.isSameDate(other._date) &&
          _groupId == other._groupId &&
          _amountEating == other._amountEating &&
          _isCooking == other._isCooking &&
          _user == other._user;

  @override
  int get hashCode =>
      _date.hashCode ^
      _groupId.hashCode ^
      _amountEating.hashCode ^
      _isCooking.hashCode ^
      _user.hashCode;

  @override
  Future addToDatabase() {
    return super.addToDatabaseByName("reservations");
  }

  @override
  int compareTo(Reservation other) {
    if (this._date == null || other == null) {
      return null;
    } else if (this._date.isSameDate(other.date)) {
      return 0;
    } else if (this.date.millisecondsSinceEpoch >
        other.date.millisecondsSinceEpoch) {
      return 1;
    }
    return -1;
  }

  @override
  String toString() {
    return 'Reservation{_date: $_date, _groupId: $_groupId, _amountEating: $_amountEating, _amountCooking: $_isCooking, _user: $_user}';
  }
}
