import 'package:digital_clock/emojis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmojiPixel extends StatefulWidget {
  final bool visible;

  EmojiPixel(this.visible);

  @override
  _EmojiPixelState createState() => _EmojiPixelState();
}

class _EmojiPixelState extends State<EmojiPixel> {
  @override
  Widget build(BuildContext context) {
    final emojis = Provider.of<Emojis>(context);
    return Container(
      child: widget.visible ? FittedBox(child: Text(emojis.emoji)) : null,
    );
  }
}
