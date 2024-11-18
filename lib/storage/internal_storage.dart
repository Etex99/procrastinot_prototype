import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InternalStorageHandler {
  static const String SEND_NOTIFICATIONS = 'SEND_NOTIFICATIONS';
  static const String NOTIFICATION_TIME = 'NOTIFICATION_TIME';
  static const String NOTIFICATION_DAYS = 'NOTIFICATION_DAYS';
  static const String DEFAULT_STUDY_DURATION = 'DEFAULT_STUDY_DURATION';
  static const String DEFAULT_BREAK_DURATION = 'DEFAULT_BREAK_DURATION';
  static const String DEFAULT_NUMBER_OF_BREAKS = 'DEFAULT_NUMBER_OF_BREAKS';

  static Map<String, dynamic> tempSettingsFormValues = {};

  Future<void> saveSettings() async {
    if (tempSettingsFormValues.containsKey(SEND_NOTIFICATIONS)) await setSendNotifications(tempSettingsFormValues[SEND_NOTIFICATIONS]);
    if (tempSettingsFormValues.containsKey(NOTIFICATION_TIME)) await setNotificationTime(tempSettingsFormValues[NOTIFICATION_TIME]);
    if (tempSettingsFormValues.containsKey(NOTIFICATION_DAYS)) await setNotificationDays(tempSettingsFormValues[NOTIFICATION_DAYS]);
    if (tempSettingsFormValues.containsKey(DEFAULT_STUDY_DURATION)) await setDefaultStudyDuration(tempSettingsFormValues[DEFAULT_STUDY_DURATION]);
    if (tempSettingsFormValues.containsKey(DEFAULT_BREAK_DURATION)) await setDefaultBreakDuration(tempSettingsFormValues[DEFAULT_BREAK_DURATION]);
    if (tempSettingsFormValues.containsKey(DEFAULT_NUMBER_OF_BREAKS)) await setDefaultNumberOfBreaks(tempSettingsFormValues[DEFAULT_NUMBER_OF_BREAKS]);

    tempSettingsFormValues.clear();
  }

  Future<void> setSendNotifications(bool sendNotifications) async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    await sp.setBool(SEND_NOTIFICATIONS, sendNotifications);
  }

  Future<bool> getSendNotifications() async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    bool result = false; // Default value
    if (await sp.containsKey(SEND_NOTIFICATIONS)) result = await sp.getBool(SEND_NOTIFICATIONS) as bool;
    return result;
  }

  Future<void> setNotificationTime(TimeOfDay t) async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    int h = t.hour;
    int m = t.minute;
    String s = '$h.$m';
    await sp.setString(NOTIFICATION_TIME, s);
  }

  Future<TimeOfDay> getNotificationTime() async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    TimeOfDay result = const TimeOfDay(hour: 16, minute: 0); // Default value
    if (await sp.containsKey(NOTIFICATION_TIME)) {
      String s = await sp.getString(NOTIFICATION_TIME) as String;
      List<String> hm = s.split('.');
      result = TimeOfDay(hour: int.parse(hm[0]), minute: int.parse(hm[1]));
    }
    return result;
  }

  Future<void> setNotificationDays(List<bool> mondayToSunday) async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    List<String> ls = [];
    for (bool b in mondayToSunday) {
      ls.add(b.toString());
    }
    await sp.setStringList(NOTIFICATION_DAYS, ls);
  }

  Future<List<bool>> getNotificationDays() async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    List<bool> result = [true, true, true, true, true, false, false]; // Default value
    if (await sp.containsKey(NOTIFICATION_DAYS)) {
      List<String> ls = await sp.getStringList(NOTIFICATION_DAYS) as List<String>;
      result.clear();
      for (String s in ls) {
        result.add(bool.parse(s));
      }
    }
    return result;
  }

  Future<void> setDefaultStudyDuration(Duration d) async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    await sp.setInt(DEFAULT_STUDY_DURATION, d.inMinutes);
  }

  Future<Duration> getDefaultStudyDuration() async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    Duration result = const Duration(hours: 2); // Default value
    if (await sp.containsKey(DEFAULT_STUDY_DURATION)) result = Duration(minutes: await sp.getInt(DEFAULT_STUDY_DURATION) as int);
    return result;
  }

  Future<void> setDefaultBreakDuration(Duration d) async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    await sp.setInt(DEFAULT_BREAK_DURATION, d.inMinutes);
  }

  Future<Duration> getDefaultBreakDuration() async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    Duration result = const Duration(minutes: 15); // Default value
    if (await sp.containsKey(DEFAULT_BREAK_DURATION)) result = Duration(minutes: await sp.getInt(DEFAULT_BREAK_DURATION) as int);
    return result;
  }

  Future<void> setDefaultNumberOfBreaks(int i) async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    await sp.setInt(DEFAULT_NUMBER_OF_BREAKS, i);
  }

  Future<int> getDefaultNumberOfBreaks() async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    int result = 1; // Default value
    if (await sp.containsKey(DEFAULT_NUMBER_OF_BREAKS)) result = await sp.getInt(DEFAULT_NUMBER_OF_BREAKS) as int;
    return result;
  }
}