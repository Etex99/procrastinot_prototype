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

class _SessionViewState extends State<SessionView> {
  Timer? _breakReturn;
  late AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
   
    _listener = AppLifecycleListener(
      onPause: () => _handleAppPause(),
      onRestart: () => _handleAppRestart(),
    );
    
    SessionManager s = SessionManager();
    
    s.startSession();

    if (s.isOnBreak()) {
      _takeBreak();
    }
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
    SessionManager.instance.stopSession();
    _listener.dispose();
    if (_breakReturn != null) _breakReturn!.cancel();
    super.dispose();
  }

  void _exit() {
    SessionManager s = SessionManager();
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
    _breakReturn = Timer((s.session.breakDuration - s.session.elapsedBreakTime), () => _returnFromBreak());
    if (!s.isOnBreak()) s.beginBreak(); // This if clause prevents unexpected behaviour when a break is resumed after app was paused
    setState(() {/* Rebuild view to show break content */},);
  }

  void _returnFromBreak() {
    if (_breakReturn != null) _breakReturn!.cancel();
    SessionManager.instance.endBreak();
    setState(() {/* Rebuild view to show session content */});
  }

  Future<void> _handleAppPause() async {
    debugPrint("App paused!");
    SessionManager s = SessionManager();

    if (_breakReturn != null) _breakReturn!.cancel();
    await s.pauseSession();
    debugPrint(s.session.toString());
  }

  Future<void> _handleAppRestart() async {
    debugPrint("App restarted!");
    SessionManager s = SessionManager();
    await s.restoreSession();
    debugPrint(s.session.toString());

    s.startSession();

    if (s.isOnBreak()) {
      _takeBreak();
    }

    setState(() {/* Rebuild view to update progress bar */});
  }
}
