import 'package:digital_clock/digits_parser.dart';
import 'package:digital_clock/emojis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmojiCharacter extends StatelessWidget {
  final String charString;
  static const _size = 20.0;

  EmojiCharacter(this.charString, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final character = Provider.of<DigitsParser>(context).charOf(charString);
    return Container(
      width: _size * 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: character.pixelPlacement.map(
          (row) {
            if (row.isEmpty) {
              return Container(
                width: _size,
                height: _size,
              );
            }
            return Row(
              children: row.map((column) {
                final emoji = Provider.of<Emojis>(context).emoji;
                return Container(
                  height: _size,
                  width: _size,
                  child: column ? FittedBox(child: Text(emoji)) : null,
                );
              }).toList(),
            );
          },
        ).toList(),
      ),
    );
  }
}
