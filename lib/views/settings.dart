import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/app_bar.dart';
import 'package:procrastinot_prototype/components/settings_form.dart';
import 'package:procrastinot_prototype/resources/theme.dart';
import 'package:procrastinot_prototype/storage/internal_storage.dart';

class SettingsView extends StatelessWidget {
  
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: MyAppBar('Settings'),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                        color: MyTheme.FOREGROUND_COLOR,
                        child: const Padding(
                            padding: EdgeInsets.all(32.0),
                            child: SettingsForm()))),
                Container(
                    color: MyTheme.BACKGROUND_COLOR,
                    height: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                            onPressed: () {InternalStorageHandler().saveSettings();},
                            icon: const Icon(
                              Icons.save,
                              color: MyTheme.ACCENT_COLOR,
                              size: 50.0,
                            )),
                        const SizedBox(width: 32.0),
                      ],
                    ))
              ],
            )));
  }
}
