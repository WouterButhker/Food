import 'package:json_annotation/json_annotation.dart';
import 'package:student/src/entities/database_item.dart';


@JsonSerializable()
class Reservation extends DatabaseItem implements Comparable<Reservation> {
  DateTime _date;
  int _groupId;
  int _amountEating;
  int _amountCooking;
  int _user;

  Reservation(int group, DateTime date, int user,
      {int amountEating = 0, int amountCooking = 0}) {
    _user = user;
    _groupId = group;
    _date = date;
    _amountCooking = amountCooking;
    _amountEating = amountEating;
  }


  Reservation.fromJson(Map<String, dynamic> json) :
    _date = json['date'],
  _groupId = json['groupId'],
  _amountEating = json['amountEating'],
  _amountCooking = json['amountCooking'],
  _user = json ['userId'];

  Map<String, dynamic> toJson() =>
      {'date': _date, 'groupId': _groupId, 'amountEating': _amountEating, 'amountCooking': _amountCooking, 'userId': _user};

  int get user => _user;

  set user(int value) {
    _user = value;
  }

  int get amountCooking => _amountCooking;

  set amountCooking(int value) {
    _amountCooking = value;
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
          _date == other._date &&
          _groupId == other._groupId &&
          _amountEating == other._amountEating &&
          _amountCooking == other._amountCooking &&
          _user == other._user;

  @override
  int get hashCode =>
      _date.hashCode ^
      _groupId.hashCode ^
      _amountEating.hashCode ^
      _amountCooking.hashCode ^
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
    } else if (this.date.millisecondsSinceEpoch > other.date.millisecondsSinceEpoch) {
      return 1;
    }
    return -1;
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month
        && this.day == other.day;
  }
}
