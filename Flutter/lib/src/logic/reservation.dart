import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'reservation.g.dart';

@JsonSerializable()
class Reservation {
  DateTime _date;
  String _group;
  int _amountEating;
  int _amountCooking;
  int _user;

  Reservation(String group, DateTime date, int user,
      {int amountEating = 0, int amountCooking = 0}) {
    _user = user;
    _group = group;
    _date = date;
    _amountCooking = amountCooking;
    _amountEating = amountEating;
  }


  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);

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

  String get group => _group;

  set group(String value) {
    _group = value;
  }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }
}
