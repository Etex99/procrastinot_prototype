import 'dart:async';
import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/progress_bar.dart';
import 'package:procrastinot_prototype/components/task_list_item.dart';
import 'package:procrastinot_prototype/data/session.dart';
import 'package:procrastinot_prototype/resources/theme.dart';
import 'package:procrastinot_prototype/views/session_break.dart';
import 'package:procrastinot_prototype/views/session_results.dart';


class SessionView extends StatefulWidget {
  const SessionView({super.key});

  @override
  State<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> with WidgetsBindingObserver {
  Timer? _autoBreakReturn;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    SessionManager s = SessionManager();
    s.startSession();

    if (s.isOnBreak()) _takeBreak();
  }

  @override
  Widget build(BuildContext context) {
    SessionManager s = SessionManager();

    if (s.isOnBreak()) {
      return BreakView(totalDuration: s.session.breakDuration, elapsedDuration: s.session.elapsedBreakTime, returnCallback: () => _returnFromBreak(),);
    }

    SessionProgressBar progressBar =
        SessionProgressBar(session: s.session);
    Widget topBar = Container(
      color: MyTheme.BACKGROUND_COLOR,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: progressBar
        ),
      ),
    );

    Function()? breakButtonFunc;
    if (s.canTakeBreak()) breakButtonFunc = () => _takeBreak();
    IconButton takeBreakButton = IconButton(
      icon: const Icon(
        Icons.coffee,
        size: 50,
      ),
      onPressed: breakButtonFunc,
      color: MyTheme.ACCENT_COLOR,
      disabledColor: MyTheme.PRIMARY_COLOR_LIGHT,
    );

    List<Widget> bodyColumnChildren = [];
    for (var i = 0; i < 3; i++) {
      bodyColumnChildren.add(TaskListItem(
          taskLabel: s.session.tasks![i],
          done: s.session.taskSuccess![i],
          onPressed: () {
            s.session.taskSuccess![i] = true;
          }));
      if (i == 2) break;
      bodyColumnChildren.add(const SizedBox(height: 8));
    }
    bodyColumnChildren.add(const SizedBox(height: 16));
    bodyColumnChildren.add(Row(
      mainAxisSize: MainAxisSize.max,
      children: [takeBreakButton],
    ));

    Widget middleContent = Container(
        color: MyTheme.FOREGROUND_COLOR,
        child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: bodyColumnChildren,
            )));

    Widget exitButton = IconButton(
        onPressed: () => _exit(),
        icon: const Icon(
          Icons.door_back_door,
          size: 50,
          color: Colors.red,
        ));

    Container bottomBar = Container(
      height: 100,
      color: MyTheme.BACKGROUND_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [exitButton, const SizedBox(width: 8.0,)],
      ),
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
      ),
    ));
  }

  @override
  void dispose() {
    if (_autoBreakReturn != null) _autoBreakReturn!.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      debugPrint("Resumed app.");
    }

    if (state == AppLifecycleState.paused) {
      debugPrint("Paused app.");
    }

    // It is pretty excessive to save the session each time the user hides the app.
    // This is a quick and dirty way to ensure that system doesn't nuke the data e.g. when cheap devices use "clear all" in app tray.
    // Luckily this is just a little json string.
    if (state == AppLifecycleState.inactive) {
      debugPrint("App is inactive.");
      SessionManager.instance.preserveSession();
    }

    if (state == AppLifecycleState.detached) {
      debugPrint("App is detached.");
    }
  }

  void _exit() {
    SessionManager s = SessionManager();
    s.endSession();

    int doneCounter = 0;
    for (var i = 0; i < s.session.taskSuccess!.length; i++) {
      if (s.session.taskSuccess![i] == true) doneCounter++;
    }

    SessionResultsArgs args =
        SessionResultsArgs(doneCounter, s.getTimeDifference());
    Navigator.pushReplacementNamed(context, '/results', arguments: args);
  }

  void _takeBreak() {
    SessionManager s = SessionManager();
    _autoBreakReturn = Timer((s.session.breakDuration - s.session.elapsedBreakTime), () => _returnFromBreak());
    if (!s.isOnBreak()) s.beginBreak(); // If-clause ensures break budget is not consumed upon session restore.
    setState(() {/* Update to show break view */},);
  }

  void _returnFromBreak() {
    if (_autoBreakReturn != null) _autoBreakReturn!.cancel();
    SessionManager.instance.endBreak();
    setState(() {/* Rebuild view to show session content */});
  }
}
