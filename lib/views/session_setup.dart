import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/app_bar.dart';
import 'package:procrastinot_prototype/components/below_keyboard.dart';
import 'package:procrastinot_prototype/components/setup_form.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class SessionSetupView extends StatelessWidget {
  const SessionSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: MyAppBar('Session Setup'),
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
                          child: SetupForm())),
                ),
                BelowKeyboard(
                  child: Container(
                      color: MyTheme.BACKGROUND_COLOR,
                      height: 100.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Spacer(flex: 1),
                          IconButton(
                              // TODO: on pressed
                              onPressed: () {},
                              icon: const Icon(
                                Icons.check_box,
                                color: MyTheme.ACCENT_COLOR,
                                size: 50.0,
                              )),
                          const SizedBox(width: 32.0)
                        ],
                      )),
                )
              ],
            )));
  }
}
