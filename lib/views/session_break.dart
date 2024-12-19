import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/progress_bar.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class BreakView extends StatelessWidget {
  final Duration totalDuration;
  final Duration elapsedDuration;
  final Function()? returnCallback;

  const BreakView({super.key, required this.totalDuration, this.elapsedDuration = Duration.zero, this.returnCallback});

  @override
  Widget build(BuildContext context) {

    Container topBar = Container(
          color: MyTheme.BACKGROUND_COLOR,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BreakProgressBar(totalDuration: totalDuration, elapsedDuration: elapsedDuration),
            ),
          ),
        );

    Container middleContent = Container(
                color: MyTheme.FOREGROUND_COLOR,
                child: const Center(
                  child: Icon(
                    Icons.coffee,
                    color: MyTheme.PRIMARY_COLOR,
                    size: 128,
                  ),
                ));

    IconButton returnButton = IconButton(
        onPressed: returnCallback,
        icon: const Icon(
          Icons.keyboard_return,
          size: 50,
          color: Colors.red,
        ));
    Container bottomBar = Container(
      height: 100,
      color: MyTheme.BACKGROUND_COLOR,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          returnButton,
          const SizedBox(width: 8.0,)
        ],
      )
    );

    return SafeArea(
        child: Scaffold(
            body: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(flex: 1, child: topBar),
        Flexible(flex: 4, child: middleContent),
        bottomBar
      ],
    )));
  }
}
