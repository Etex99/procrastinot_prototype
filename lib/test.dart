import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:procrastinot_prototype/storage/internal_storage.dart';
import 'package:procrastinot_prototype/util/format.dart';

void main(List<String> args) {

  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('-- Internal Storage Handler --', () {
    test('Send Notifications -preference setter/getter', () async {
      InternalStorageHandler i = InternalStorageHandler();
      await i.setSendNotifications(true);
      expect(await i.getSendNotifications(), true);
    });
    test('Notification time -preference setter/getter', () async {
      InternalStorageHandler i = InternalStorageHandler();
      const TimeOfDay t = TimeOfDay(hour: 4, minute: 20);
      await i.setNotificationTime(t);
      expect(await i.getNotificationTime(), t);
    });
    test('Notification days -preference setter/getter', () async {
      InternalStorageHandler i = InternalStorageHandler();
      const List<bool> lb = [true, false, true, false, true, false, true];
      await i.setNotificationDays(lb);
      expect(await i.getNotificationDays(), lb);
    });
    test('Default study duration -preference setter/getter', () async {
      InternalStorageHandler i = InternalStorageHandler();
      const Duration d = Duration(hours: 4, minutes: 20);
      await i.setDefaultStudyDuration(d);
      expect(await i.getDefaultStudyDuration(), d);
    });
    test('Default break duration -preference setter/getter', () async {
      InternalStorageHandler i = InternalStorageHandler();
      const Duration d = Duration(hours: 66, minutes: 60);
      await i.setDefaultBreakDuration(d);
      expect(await i.getDefaultBreakDuration(), d);
    });
    test('Number of breaks -preference setter/getter', () async {
      InternalStorageHandler i = InternalStorageHandler();
      await i.setDefaultNumberOfBreaks(3);
      expect(await i.getDefaultNumberOfBreaks(), 3);
    });
    
  });

  group('-- My Formatter --', () {
    test('String => TimeOfDay', () {
      expect(MyFormatter.stringToTimeOfDay('1.00'), const TimeOfDay(hour: 1, minute: 0));
      expect(MyFormatter.stringToTimeOfDay('1.01'), const TimeOfDay(hour: 1, minute: 1));
      expect(MyFormatter.stringToTimeOfDay('0.01'), const TimeOfDay(hour: 0, minute: 1));
      expect(MyFormatter.stringToTimeOfDay('0.00'), const TimeOfDay(hour: 0, minute: 0));
      expect(MyFormatter.stringToTimeOfDay('11.00'), const TimeOfDay(hour: 11, minute: 0));
      expect(MyFormatter.stringToTimeOfDay('11.11'), const TimeOfDay(hour: 11, minute: 11));
      expect(MyFormatter.stringToTimeOfDay('0.11'), const TimeOfDay(hour: 0, minute: 11));
    });
    test('TimeOfDay => String', () {
      expect(MyFormatter.timeOfDayToString(const TimeOfDay(hour: 1, minute: 0)), '1.00');
      expect(MyFormatter.timeOfDayToString(const TimeOfDay(hour: 1, minute: 1)), '1.01');
      expect(MyFormatter.timeOfDayToString(const TimeOfDay(hour: 0, minute: 1)), '0.01');
      expect(MyFormatter.timeOfDayToString(const TimeOfDay(hour: 0, minute: 0)), '0.00');
      expect(MyFormatter.timeOfDayToString(const TimeOfDay(hour: 11, minute: 0)), '11.00');
      expect(MyFormatter.timeOfDayToString(const TimeOfDay(hour: 11, minute: 11)), '11.11');
      expect(MyFormatter.timeOfDayToString(const TimeOfDay(hour: 0, minute: 11)), '0.11');
    });
    test('Duration => String', () {
      expect(MyFormatter.durationToString(const Duration(hours: 1, minutes: 0)), '1.00');
      expect(MyFormatter.durationToString(const Duration(hours: 1, minutes: 1)), '1.01');
      expect(MyFormatter.durationToString(const Duration(hours: 0, minutes: 1)), '0.01');
      expect(MyFormatter.durationToString(const Duration(hours: 0, minutes: 0)), '0.00');
      expect(MyFormatter.durationToString(const Duration(hours: 11, minutes: 0)), '11.00');
      expect(MyFormatter.durationToString(const Duration(hours: 11, minutes: 11)), '11.11');
      expect(MyFormatter.durationToString(const Duration(hours: 0, minutes: 11)), '0.11');
    });
    test('String => Duration', () {
      expect(MyFormatter.stringToDuration('1.00'), const Duration(hours: 1, minutes: 0));
      expect(MyFormatter.stringToDuration('1.01'), const Duration(hours: 1, minutes: 1));
      expect(MyFormatter.stringToDuration('0.01'), const Duration(hours: 0, minutes: 1));
      expect(MyFormatter.stringToDuration('0.00'), const Duration(hours: 0, minutes: 0));
      expect(MyFormatter.stringToDuration('11.00'), const Duration(hours: 11, minutes: 0));
      expect(MyFormatter.stringToDuration('11.11'), const Duration(hours: 11, minutes: 11));
      expect(MyFormatter.stringToDuration('0.11'), const Duration(hours: 0, minutes: 11));
    });
  });
}