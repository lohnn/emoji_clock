import 'package:characters/characters.dart';

class DigitsParser {
  Map<String, Character> _digits;

  DigitsParser() {
//    final digits = await rootBundle.loadString("assets/digits");
    final newLinePos = digits.indexOf("\n");
    final letterMap = digits.substring(0, newLinePos);
    final pixelMap = digits.substring(newLinePos + 1);
    _digits = Character.parseDigitMatrix(letterMap, pixelMap);
  }

  Character charOf(String char) {
    return _digits[char];
  }
}

class Character {
  final Iterable<Iterable<bool>> pixelPlacement;

  Character._(this.pixelPlacement);

  static Map<String, Character> parseDigitMatrix(
    String letterMap,
    String pixelMap, {
    String pixelCharacter = "#",
    int characterWidth = 6,
    int characterHeight = 7,
  }) {
    assert(pixelMap.isNotEmpty);
    assert(letterMap.isNotEmpty);
    assert(pixelCharacter.isNotEmpty);

    final rows = pixelMap.split("\n");
    //Make sure we have all the rows we are asking for
    assert(rows.length == characterHeight * letterMap.length);

    return Map.fromEntries(
      List.generate(
        letterMap.length,
        (index) => MapEntry(
          letterMap[index],
          Character.fromMatrix(
            rows.sublist(
                index * characterHeight, (index + 1) * characterHeight),
            pixelCharacter,
          ),
        ),
      ),
    );
  }

  factory Character.fromMatrix(List<String> sublist, String pixelCharacter) {
    return Character._(
      sublist.map(
        (row) => row.characters.map(
          (column) => column == "#",
        ),
      ),
    );
  }
}

const digits = """0123456789:
 ###
#   #
#   #
#   #
#   #
#   #
 ###
  #
###
  #
  #
  #
  #
#####
 ###
#   #
   #
  #
 #
#
#####
 ###
#   #
    #
  ##
    #
#   #
 ###
#
#
#
# #
#####
  #
  #
#####
#
#
####
    #
    #
####
 ###
#   #
#
####
#   #
#   #
 ###
#####
    #
   #
  #
  #
  #
  #
 ###
#   #
#   #
 ###
#   #
#   #
 ###
 ###
#   #
#   #
 ####
    #
#   #
 ###


  #

  #

""";
