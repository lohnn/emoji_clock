import 'package:digital_clock/digits_parser.dart';
import 'package:digital_clock/emojis.dart';

/// Class that takes care of loading all required components.
///
/// To be used for loading all slow components for the clock before showing it.
class ClockInit {
  final CharParser charParser;
  final Emojis emojis;

  ClockInit._(this.charParser, this.emojis);

  static Future<ClockInit> init() async {
    final init = await Future.wait(
      [
        CharParser.init(),
        Emojis.init(),
      ],
    );
    return ClockInit._(init[0], init[1]);
  }
}
