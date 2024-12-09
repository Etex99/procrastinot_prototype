import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class SessionResults extends StatelessWidget {
  const SessionResults ({super.key});

  @override
  Widget build(BuildContext context) {
    SessionResultsArgs args = ModalRoute.of(context)!.settings.arguments as SessionResultsArgs;
    int completedTasks = args.completedTasks;
    int timeDifferenceInMinutes = args.timeDifferenceInMinutes;
    debugPrint('$completedTasks, $timeDifferenceInMinutes');

    String titleText = 'Session ended roughly on time.';
    if (timeDifferenceInMinutes <= -15) {
      titleText = 'Session ended early.';
    } else if (timeDifferenceInMinutes >= 15) {
      titleText = 'Session ended with overtime.';
    }

    Widget topBar = Container(
        color: MyTheme.BACKGROUND_COLOR,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: MySubtitle(text: titleText)),
        ));

    IconData reactionEmoji;
    String praise;
    switch (completedTasks) {
      case 0:
        reactionEmoji = Icons.sentiment_neutral;
        praise = "All days can\'t be good days.";
        break;
      case 1:
        reactionEmoji = Icons.sentiment_satisfied;
        praise = "Nice!";
        break;
      case 2:
        reactionEmoji = Icons.sentiment_satisfied_alt;
        praise = "Good job!";
        break;
      case 3:
        reactionEmoji = Icons.sentiment_very_satisfied;
        praise = "Awesome!";
        break;
      default:
        reactionEmoji = Icons.help;
        praise = "Huh?";
    }

    Widget middle = Container(
      color: MyTheme.FOREGROUND_COLOR,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MySubtitle(text: '${completedTasks}/3 tasks completed.'),
              Icon(reactionEmoji, color: MyTheme.PRIMARY_COLOR, size: 128),
              MySubtitle(text: praise)
            ],
          )),
    );

    Widget exitButton = IconButton(
      onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
      icon: const Icon(
        Icons.door_back_door,
        color: Colors.red,
        size: 50,
      ),
    );

    Widget inspectButton = IconButton(
      // TODO: push analysis view.
      onPressed: () {},
      icon: const Icon(
        Icons.psychology,
        color: MyTheme.ACCENT_COLOR,
        size: 50,
      ),
    );

    List<Widget> bottomBarChildren = [];
    if (completedTasks == 3) {
      bottomBarChildren.add(exitButton);
    }
    bottomBarChildren.add(const Spacer());
    bottomBarChildren.add(inspectButton);

    Widget bottomBar = Container(
        height: 100,
        color: MyTheme.BACKGROUND_COLOR,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: bottomBarChildren,
            )));

    return SafeArea(
        child: Scaffold(
            body: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(flex: 1, child: topBar),
        Flexible(flex: 4, child: middle),
        bottomBar
      ],
    )));
  }
}

class SessionResultsArgs {
  final int completedTasks;
  final int timeDifferenceInMinutes;

  const SessionResultsArgs(this.completedTasks, this.timeDifferenceInMinutes);
}
