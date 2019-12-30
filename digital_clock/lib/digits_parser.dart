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

  int get width => pixelPlacement.elementAt(0).length;

  Iterable<bool> get singleIterablePixelPlacement =>
      pixelPlacement.expand((list) => list);

  Character._(this.pixelPlacement);

  static Map<String, Character> parseDigitMatrix(
    String letterMap,
    String pixelMap, {
    String pixelCharacter = "#",
    int characterWidth = 5,
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
              index * characterHeight,
              (index + 1) * characterHeight,
            ),
            pixelCharacter,
            characterWidth,
            characterHeight,
          ),
        ),
      ),
    )..putIfAbsent("",
        () => Character.empty(width: characterWidth, height: characterHeight));
  }

  static Character empty({int width, int height}) {
    return Character._(
      List.generate(
        height,
        (y) => List.generate(
          width,
          (x) => false,
        ),
      ),
    );
  }

  factory Character.fromMatrix(
    List<String> characterPixels,
    String pixelCharacter,
    int characterWidth,
    int characterHeight,
  ) {
    final pixelCharIndex = pixelCharacter.codeUnitAt(0);
    return Character._(
      List.generate(
        characterHeight,
        (y) => List.generate(
          characterWidth,
          (x) {
            final pixelRow = characterPixels[y];
            return x >= pixelRow.length
                ? false
                : pixelRow.codeUnitAt(x) == pixelCharIndex;
          },
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
