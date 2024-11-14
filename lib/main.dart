import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/views/all.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/home',
        routes: {
          '/home': (context) => const HomeView(),
          '/setup': (context) => const SessionSetupView(),
          '/settings': (context) => const SettingsView()
        }
    );
  }
}
