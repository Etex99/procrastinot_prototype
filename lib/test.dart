import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:procrastinot_prototype/storage/internal_storage.dart';

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
      const Duration d = Duration(hours: 4, minutes: 2);
      await i.setDefaultStudyDuration(d);
      expect(await i.getDefaultStudyDuration(), d);
    });
    test('Default break duration -preference setter/getter', () async {
      InternalStorageHandler i = InternalStorageHandler();
      const Duration d = Duration(hours: 66, minutes: 6);
      await i.setDefaultBreakDuration(d);
      expect(await i.getDefaultBreakDuration(), d);
    });
    test('Number of breaks -preference setter/getter', () async {
      InternalStorageHandler i = InternalStorageHandler();
      await i.setDefaultNumberOfBreaks(3);
      expect(await i.getDefaultNumberOfBreaks(), 3);
    });
    
  });

}