import 'package:digital_clock/digits_parser.dart';
import 'package:digital_clock/emoji_pixel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Visual representation of a [Character] consisting of emojis.
///
/// The pixels are mapped to emojis using [EmojiPixel]
class EmojiCharacter extends StatefulWidget {
  final String charString;

  EmojiCharacter(this.charString, {Key key}) : super(key: key);

  @override
  _EmojiCharacterState createState() => _EmojiCharacterState(charString);
}

class _EmojiCharacterState extends State<EmojiCharacter> {
  String charString;
  Widget toRender;

  _EmojiCharacterState(this.charString);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    toRender = createTree();
  }

  @override
  void didUpdateWidget(EmojiCharacter oldWidget) {
    super.didUpdateWidget(oldWidget);
    charString = widget.charString;
    if (charString != oldWidget.charString) {
      toRender = createTree();
    }
  }

  @override
  Widget build(BuildContext context) => toRender;

  Widget createTree() {
    final character =
        Provider.of<CharParser>(context).charOf(widget.charString);
    return Container(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: character.width,
        children: character.singleIterablePixelPlacement
            .map((pixelVisibility) => EmojiPixel(pixelVisibility))
            .toList(),
      ),
    );
  }
}
