import 'package:digital_clock/digits_parser.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("Hejsan", () async {
    final digits = await DigitsParser().getDigits();
    print(digits);
  });
}
