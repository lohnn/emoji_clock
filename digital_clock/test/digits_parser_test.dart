import 'package:digital_clock/digits_parser.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("Hejsan", () async {
    final digits = await DigitsParser().getDigits();
    digits.forEach((actual, digit) {
      print(actual);
      digit.pixelPlacement.forEach((e) {
        final row = e.map((bool) => bool ? "#" : " ");
        print(row);
      });
      print("");
    });
  });
}
