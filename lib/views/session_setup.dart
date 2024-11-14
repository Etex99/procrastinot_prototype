import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/app_bar.dart';
import 'package:procrastinot_prototype/components/input_fields.dart';
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
                      child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: ListView(
                            itemExtent: 100.0,
                            children: [
                              /*
                              Align(alignment: Alignment.centerLeft, child: MySubtitle(text: 'Duration')),
                              SelectTimeField(labelText: 'Study duration:', hintText: '3.00',),
                              SelectTimeField(labelText: 'Break duration:', hintText: '0.15',),
                              SelectNumberField(labelText: 'Number of breaks:'),
                              Align(alignment: Alignment.centerLeft, child: MySubtitle(text: 'Priority tasks')),
                              EnterStringField(labelText: '#1'),
                              EnterStringField(labelText: '#2'),
                              EnterStringField(labelText: '#3')
                              */
                            ],
                          ))),
                ),
                Container(
                    color: MyTheme.BACKGROUND_COLOR,
                    height: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Spacer(flex: 1),
                        IconButton(
                            onPressed: () => print('TODO!'),
                            icon: const Icon(
                              Icons.check_box,
                              color: MyTheme.ACCENT_COLOR,
                              size: 50.0,
                            )),
                        const SizedBox(width: 32.0)
                      ],
                    ))
              ],
            )));
  }
}
