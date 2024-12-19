import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/data/session.dart';
import 'package:procrastinot_prototype/storage/internal_storage.dart';
import 'package:procrastinot_prototype/views/all.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: InternalStorageHandler().getResumeSession(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return const SizedBox.shrink();

          if (snapshot.data == true) {
            return FutureBuilder(
                future: SessionManager().restoreSession(),
                builder: (context, AsyncSnapshot snapshot) {

                  if (!snapshot.hasData) return const SizedBox.shrink();

                  return MaterialApp(initialRoute: '/session', routes: {
                    '/home': (context) => const HomeView(),
                    '/setup': (context) => const SessionSetupView(),
                    '/settings': (context) => const SettingsView(),
                    '/session': (context) => const SessionView(),
                    '/help': (context) => const SetupHelp(),
                    '/results': (context) => const SessionResults(),
                    '/analysis': (context) => const SessionAnalysis()
                  });
                });
          }

          return MaterialApp(initialRoute: '/home', routes: {
            '/home': (context) => const HomeView(),
            '/setup': (context) => const SessionSetupView(),
            '/settings': (context) => const SettingsView(),
            '/session': (context) => const SessionView(),
            '/help': (context) => const SetupHelp(),
            '/results': (context) => const SessionResults(),
            '/analysis': (context) => const SessionAnalysis()
          });
        });
  }
}
