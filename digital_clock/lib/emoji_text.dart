import 'package:digital_clock/digits_parser.dart';
import 'package:digital_clock/emojis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final emojis = Provider.of<Emojis>(context);
    final character =
        Provider.of<DigitsParser>(context).charOf(widget.charString);
    final temp = character.singleIterablePixelPlacement.map((pixel) {
      return Container(
        child: pixel ? FittedBox(child: Text(emojis.emoji)) : null,
      );
    }).toList();
    return Container(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 5,
        children: temp,
      ),
    );
  }
}
