import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/progress_bar.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class BreakView extends StatelessWidget {
  const BreakView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 100,
          color: MyTheme.BACKGROUND_COLOR,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [BreakProgressBar()]),
          ),
        ),
        Expanded(
            child: Container(
                color: MyTheme.FOREGROUND_COLOR,
                child: const Center(
                  child: Icon(
                    Icons.coffee,
                    color: MyTheme.PRIMARY_COLOR,
                    size: 128,
                  ),
                )))
      ],
    )));
  }
}
