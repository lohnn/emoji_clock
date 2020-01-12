/// Parses characters and provides them with [charOf].
class CharParser {
  Map<String, Character> _digits;

  CharParser() {
    final newLinePos = _digitsString.indexOf("\n");
    final letterMap = _digitsString.substring(0, newLinePos);
    final pixelMap = _digitsString.substring(newLinePos + 1);
    _digits = Character._parseDigitMatrix(letterMap, pixelMap);
  }

  /// Gets a character from the map of supported characters.
  ///
  /// If character does not exist, null will be returned.
  Character charOf(String char) {
    return _digits[char];
  }

  Future<CharParser> init() async {
    return CharParser();
  }
}

/// Pixel representation of a character.
///
/// [_pixelPlacement] is used as a matrix for pixel locations where boolean
/// value true means visible and false means invisible.
class Character {
  final Iterable<Iterable<bool>> _pixelPlacement;

  int get width => _pixelPlacement.elementAt(0).length;

  Iterable<bool> get singleIterablePixelPlacement =>
      _pixelPlacement.expand((list) => list);

  Character._(this._pixelPlacement);

  static Map<String, Character> _parseDigitMatrix(
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
          Character._fromStringMatrix(
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
    )..putIfAbsent(
        "",
        () => Character._createEmptyCharacter(
            width: characterWidth, height: characterHeight));
  }

  static Character _createEmptyCharacter({int width, int height}) {
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

  factory Character._fromStringMatrix(
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

const _digitsString = """0123456789:PAM
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


####
#   #
#   #
####
#
#
#
 ###
#   #
#   #
#####
#   #
#   #
#   #
 # #
# # #
# # #
# # #
# # #
#   #
#   #""";
