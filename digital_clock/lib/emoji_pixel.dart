import 'package:digital_clock/emoji_text.dart';
import 'package:digital_clock/emojis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// One pixel for use in a [EmojiCharacter].
///
/// Will display an emoji that, each time it turns from invisible to visible
/// will display a new emoji.
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
    if (visible && visible != oldWidget.visible) {
      currentEmoji = emojis.emoji;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOutSine,
      child: Container(child: FittedBox(child: Text(currentEmoji))),
    );
  }
}
