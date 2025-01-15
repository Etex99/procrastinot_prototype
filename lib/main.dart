import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/data/session.dart';
import 'package:procrastinot_prototype/storage/internal_storage.dart';
import 'package:procrastinot_prototype/views/all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isResume = await InternalStorageHandler().getResumeSession();
  if (isResume) {
    debugPrint("Restoring session at launch.");
    await SessionManager.instance.restoreSession();
    runApp(const MainApp(initialRoute: "/session",));
  }
  runApp(const MainApp(initialRoute: "/home",));
}

class MainApp extends StatelessWidget {
  final String initialRoute;
  const MainApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( initialRoute: initialRoute, routes: {
      '/home': (context) => const HomeView(),
      '/setup': (context) => const SessionSetupView(),
      '/settings': (context) => const SettingsView(),
      '/session': (context) => const SessionView(),
      '/help': (context) => const SetupHelp(),
      '/results': (context) => const SessionResults(),
      '/analysis': (context) => const SessionAnalysis()
    });
  }
}
