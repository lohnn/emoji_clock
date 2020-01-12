// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:digital_clock/clock_init.dart';
import 'package:digital_clock/digits_parser.dart';
import 'package:digital_clock/emoji_text.dart';
import 'package:digital_clock/emojis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

const _lightBackground = Color(0xFFF9F8F0);
const _darkBackground = Colors.black;

/// A digital clock where the pixels of the digits consists of emojis.
///
/// This widget is for initializing the parsers and making sure everything is
/// loaded before showing the clock face.
class EmojiClock extends StatelessWidget {
  final ClockModel model;

  const EmojiClock(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureProvider<ClockInit>(
      create: (_) => ClockInit.init(),
      child: Consumer<ClockInit>(
        child: _EmojiClockFace(model),
        builder: (_, clockInit, clockFace) {
          return AnimatedSwitcher(
            duration: Duration(seconds: 3),
            child: clockInit != null
                ? MultiProvider(
                    providers: <Provider>[
                      Provider<CharParser>.value(value: clockInit.charParser),
                      Provider<Emojis>.value(value: clockInit.emojis),
                    ],
                    child: clockFace,
                  )
                : Container(color: _darkBackground),
          );
        },
      ),
    );
  }
}

/// Actual implementation of the clock face.
class _EmojiClockFace extends StatefulWidget {
  const _EmojiClockFace(this.model);

  final ClockModel model;

  @override
  _EmojiClockFaceState createState() => _EmojiClockFaceState();
}

class _EmojiClockFaceState extends State<_EmojiClockFace> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(_EmojiClockFace oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).brightness == Brightness.light
        ? _lightBackground
        : _darkBackground;
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final amPm =
        !widget.model.is24HourFormat ? DateFormat('a').format(_dateTime) : null;
    final minute = DateFormat('mm').format(_dateTime);

    final separatorText = _dateTime.second % 3 > 0 ? ":" : "";

    return Container(
      constraints: BoxConstraints.expand(),
      color: backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(left: 10)),
          Flexible(
            child: EmojiCharacter(hour.substring(0, 1), key: Key("hour1")),
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          Flexible(
            child: EmojiCharacter(hour.substring(1, 2), key: Key("hour2")),
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          Flexible(child: EmojiCharacter(separatorText, key: Key("colon1"))),
          const Padding(padding: EdgeInsets.only(left: 10)),
          Flexible(
            child: EmojiCharacter(minute.substring(0, 1), key: Key("minute1")),
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          Flexible(
            child: EmojiCharacter(minute.substring(1, 2), key: Key("minute2")),
          ),
          const Padding(padding: EdgeInsets.only(left: 10)),
          if (amPm != null) ...[
            Flexible(
              child: EmojiCharacter(amPm.substring(0, 1), key: Key("AP")),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Flexible(
              child: EmojiCharacter(amPm.substring(1, 2), key: Key("M")),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
          ]
        ],
      ),
    );
  }
}
