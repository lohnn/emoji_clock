import 'package:digital_clock/digits_parser.dart';
import 'package:digital_clock/emojis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmojiCharacter extends StatefulWidget {
  final String charString;
  static const _size = 20.0;

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
    return Container(
      width: EmojiCharacter._size * 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: character.pixelPlacement.map(
          (row) {
            if (row.isEmpty) {
              return Container(
                width: EmojiCharacter._size,
                height: EmojiCharacter._size,
              );
            }
            return Row(
              children: row.map((column) {
                return Container(
                  height: EmojiCharacter._size,
                  width: EmojiCharacter._size,
//                  color: column ? Colors.orange : null,
                  child: column ? FittedBox(child: Text(emojis.emoji)) : null,
                );
              }).toList(),
            );
          },
        ).toList(),
      ),
    );
  }
}
