import 'package:flutter/material.dart';

class MyFormatter {
  static String timeOfDayToString(TimeOfDay t) {
    int h = t.hour;
    int m = t.minute;
    if (m < 10) return '${h}.0${m}';
    return '${h}.${m}';
  }
  static TimeOfDay stringToTimeOfDay(String s) {
    List<String> split = s.split('.');
    return TimeOfDay(hour: int.parse(split[0]), minute: int.parse(split[1]));
  }
  static String durationToString(Duration d) {
    int m = d.inMinutes;
    int h = (d.inMinutes / 60).floor();
    if (h == 0 && m < 10) return '0.0${m}';
    if (h == 0 && m >= 10) return '0.${m}';
    m = m % (h * 60);
    if (m < 10) return '${h}.0${m}';
    return '${h}.${m}';
  }
  static Duration stringToDuration(String s) {
    List<String> split = s.split('.');
    return Duration(hours: int.parse(split[0]), minutes: int.parse(split[1]));
  }
}