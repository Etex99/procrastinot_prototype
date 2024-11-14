import 'package:flutter/material.dart';

class MyFormatter {
  static String timeOfDayToString(TimeOfDay t) {
    int h = t.hour;
    int m = t.minute;
    return '$h.$m';
  }
  static String durationToString(Duration d) {
    int m = d.inMinutes;
    int h = (d.inMinutes / 60).floor();
    if (h == 0) return '0.$m';
    m = m % (h * 60);
    return '$h.$m';
  }
}