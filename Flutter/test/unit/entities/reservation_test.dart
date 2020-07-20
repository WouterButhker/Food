
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/entities/reservation.dart';

void main() {
  Reservation res = Reservation(1, DateTime.utc(2020), 1);

  group("Reservation class", () {
    Map<String, dynamic> json = {"date": "2020-01-01T00:00:00.000Z", "groupId": 1, "amountEating": 0, "isCooking": false, "userId": 1};

    test("toString", () {
      expect(res.toString(), "Reservation{_date: 2020-01-01 00:00:00.000Z, _groupId: 1, _amountEating: 0, _amountCooking: false, _user: 1}");
    });

    test("toJson", () {
      expect(res.toJson(), json);
    });

    test("fromJson", () {
      expect(Reservation.fromJson(json), res);
    });
  });

  group("Server communication", () {
    test("Send reservation", () async {
      Response response = await ServerCommunication.sendReservation(res);
      expect(response.statusCode, 200);
    });
  });
}