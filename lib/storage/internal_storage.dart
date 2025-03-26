import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:procrastinot_prototype/data/session.dart';
import 'package:procrastinot_prototype/util/format.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InternalStorageHandler {
  static const String SEND_NOTIFICATIONS = 'SEND_NOTIFICATIONS';
  static const String NOTIFICATION_TIME = 'NOTIFICATION_TIME';
  static const String NOTIFICATION_DAYS = 'NOTIFICATION_DAYS';
  static const String DEFAULT_STUDY_DURATION = 'DEFAULT_STUDY_DURATION';
  static const String DEFAULT_BREAK_DURATION = 'DEFAULT_BREAK_DURATION';
  static const String DEFAULT_NUMBER_OF_BREAKS = 'DEFAULT_NUMBER_OF_BREAKS';
  static const String SESSION_SAVE_FILE = "/session.txt";
  static const String RESUME_SESSION = 'RESUME_SESSION';
  static const String SAVE_TIMESTAMP = 'SAVE_TIMESTAMP';
  static const String MOCK_PEOPLE_COUNT = 'MOCK_PEOPLE_COUNT';
  static const String MOCK_TIMESTAMP = 'MOCK_TIMESTAMP';

  static Map<String, dynamic> tempSettingsFormValues = {};

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _sessionSaveFile async {
    final path = await _localPath;
    return File('$path$SESSION_SAVE_FILE');
  }

  Future<void> saveSession(Session session) async {
    File file = await _sessionSaveFile;
    String jsonStr = jsonEncode(session);
    await file.writeAsString(jsonStr);
  }
  Future<Session> loadSession() async {
    File file = await _sessionSaveFile;
    if (!(await file.exists())) return Session();
    String jsonStr = await file.readAsString();
    return Session.fromJson(jsonDecode(jsonStr) as Map<String, dynamic>);
  }

  Future<void> saveSettings() async {
    if (tempSettingsFormValues.containsKey(SEND_NOTIFICATIONS)) {
      await setSendNotifications(tempSettingsFormValues[SEND_NOTIFICATIONS]);
    }
    if (tempSettingsFormValues.containsKey(NOTIFICATION_TIME)) {
      await setNotificationTime(MyFormatter.stringToTimeOfDay(tempSettingsFormValues[NOTIFICATION_TIME]));
    }
    if (tempSettingsFormValues.containsKey(NOTIFICATION_DAYS)) {
      await setNotificationDays(tempSettingsFormValues[NOTIFICATION_DAYS]);
    }
    if (tempSettingsFormValues.containsKey(DEFAULT_STUDY_DURATION)) {
      await setDefaultStudyDuration(MyFormatter.stringToDuration(tempSettingsFormValues[DEFAULT_STUDY_DURATION]));
    }
    if (tempSettingsFormValues.containsKey(DEFAULT_BREAK_DURATION)) {
      await setDefaultBreakDuration(MyFormatter.stringToDuration(tempSettingsFormValues[DEFAULT_BREAK_DURATION]));
    }
    if (tempSettingsFormValues.containsKey(DEFAULT_NUMBER_OF_BREAKS)) {
      await setDefaultNumberOfBreaks(int.parse(tempSettingsFormValues[DEFAULT_NUMBER_OF_BREAKS]));
    }

    tempSettingsFormValues.clear();
  }

  Future<void> setResumeSession(bool resumeSession) async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    await sp.setBool(RESUME_SESSION, resumeSession);
  }

  Future<bool> getResumeSession() async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    bool result = false; // Default value
    if (await sp.containsKey(RESUME_SESSION)) result = await sp.getBool(RESUME_SESSION) as bool;
    return result;
  }

  Future<void> setSessionSaveTimestamp(DateTime timestamp) async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    await sp.setString(SAVE_TIMESTAMP, timestamp.toString());
  }
  Future<DateTime> getPausedTimestamp() async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    DateTime result = DateTime.timestamp(); // Default value
    String timestampStr;
    if (await sp.containsKey(SAVE_TIMESTAMP)) {
      timestampStr = await sp.getString(SAVE_TIMESTAMP) as String;
      result = DateTime.parse(timestampStr);
    }
    return result;
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

  Future<void> setMockPeopleCount(int i) async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    await sp.setInt(MOCK_PEOPLE_COUNT, i);
  }

  Future<int> getMockPeopleCount() async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    int result = 0; // Default value
    if (await sp.containsKey(MOCK_PEOPLE_COUNT)) result = await sp.getInt(MOCK_PEOPLE_COUNT) as int;
    return result;
  }

  Future<void> setLastMock(DateTime timestamp) async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    await sp.setString(MOCK_TIMESTAMP, timestamp.toString());
  }
  Future<DateTime> getLastMock() async {
    final SharedPreferencesAsync sp = SharedPreferencesAsync();
    DateTime result = DateTime.fromMicrosecondsSinceEpoch(0); // Default value
    String timestampStr;
    if (await sp.containsKey(MOCK_TIMESTAMP)) {
      timestampStr = await sp.getString(MOCK_TIMESTAMP) as String;
      result = DateTime.parse(timestampStr);
    }
    return result;
  }
}