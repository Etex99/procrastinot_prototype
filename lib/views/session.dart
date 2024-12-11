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
  SessionManager? sessionManager;
  final List<bool> _taskDone = [false, false, false];
  int _doneCounter = 0;
  Timer? _breakReturn;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (sessionManager == null) {
      SessionViewArgs args =
          ModalRoute.of(context)!.settings.arguments as SessionViewArgs;
      sessionManager = SessionManager(session: args.session);
    }
  }

  @override
  Widget build(BuildContext context) {
    SessionProgressBar progressBar =
        SessionProgressBar(session: sessionManager!.session);
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
    if (sessionManager!.canTakeBreak()) breakButtonFunc = () => _takeBreak();
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
          taskLabel: sessionManager!.session.tasks![i],
          onPressed: () {
            _taskDone[i] = true;
            _doneCounter++;
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
    sessionManager!.endSession();
    super.dispose();
  }

  void _exit() {
    SessionResultsArgs args =
        SessionResultsArgs(_doneCounter, sessionManager!.getTimeDifference());
    Navigator.pushReplacementNamed(context, '/results', arguments: args);
  }

  void _takeBreak() {
    _breakReturn = Timer(sessionManager!.session.breakDuration, () => _returnFromBreak());
    sessionManager!.beginBreak();
    Navigator.pushNamed(context, '/break',
        arguments: BreakViewArgs(sessionManager!.session.breakDuration, () => _returnFromBreak()));
  }

  void _returnFromBreak() {
    if (_breakReturn!.isActive) _breakReturn!.cancel();
    sessionManager!.endBreak();
    Navigator.pop(context);
    setState(() {/* Rebuild view to update progress bar */});
  }
}

class SessionViewArgs {
  final Session session;

  SessionViewArgs(this.session);
}
