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
  Emojis emojis;
  String currentEmoji;
  bool visible;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    emojis = Provider.of<Emojis>(context);
    currentEmoji = emojis.emoji;
    visible = widget.visible;
  }

  @override
  void didUpdateWidget(EmojiPixel oldWidget) {
    super.didUpdateWidget(oldWidget);
    visible = widget.visible;
    if (visible != oldWidget.visible) {
      currentEmoji = emojis.emoji;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.visible ? FittedBox(child: Text(currentEmoji)) : null,
    );
  }
}
