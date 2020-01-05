// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:digital_clock/emoji_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

final _lightBackground = Color(0xFFF9F8F0);

final _darkBackground = Colors.black;

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
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
  void didUpdateWidget(DigitalClock oldWidget) {
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
    final minute = DateFormat('mm').format(_dateTime);
    final second = DateFormat('ss').format(_dateTime);

    final separatorText = _dateTime.second % 3 > 0 ? ":" : "";

    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: EmojiCharacter(hour.substring(0, 1), key: Key("hour1")),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Flexible(
              child: EmojiCharacter(
                hour.substring(1, 2),
                key: Key("hour2"),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Flexible(child: EmojiCharacter(separatorText, key: Key("colon1"))),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Flexible(
              child: EmojiCharacter(
                minute.substring(0, 1),
                key: Key("minute1"),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Flexible(
              child: EmojiCharacter(
                minute.substring(1, 2),
                key: Key("minute2"),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Flexible(child: EmojiCharacter(separatorText, key: Key("colon2"))),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Flexible(
              child: EmojiCharacter(
                second.substring(0, 1),
                key: Key("second1"),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Flexible(
              child: EmojiCharacter(
                second.substring(1, 2),
                key: Key("second2"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
