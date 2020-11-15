import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:student/src/communication/server_communication.dart';
import 'package:student/src/entities/reservation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Reservation res = Reservation(1, DateTime.utc(2020), 1);

  group("Reservation class", () {
    Map<String, dynamic> json = { "reservationKey": {"myDate": "2020-01-01", "groupId": 1, "userId": 1}, "isCooking": false, "amountEating": 0 };

    test("toString", () {
      expect(res.toString(),
          "Reservation{_date: 2020-01-01 00:00:00.000Z, _groupId: 1, _amountEating: 0, _isCooking: false, _user: 1}");
    });

    test("toJson", () {
      Map<String, dynamic> expected = {
        'date': '2020-01-01T00:00:00.000Z',
        'groupId': 1,
        'amountEating': 0,
        'isCooking': false,
        'userId': 1
      };
      expect(res.toJson(), expected);
    });

    test("fromJson", () {
      expect(Reservation.fromJson(json), res);
    });

    test("equals", () {
      Reservation res2 = Reservation(1, DateTime.utc(2020), 1);
      Reservation res3 = Reservation(1, DateTime.utc(2020), 1, isCooking: true);
      expect(true, res == res2);
      expect(false, res == res3);
    });
  });

  group("Server communication", () {
    test("Send reservation", () async {
      Response response = await ServerCommunication.sendReservation(res);
      expect(response.statusCode, 200);
    });
  });
}
