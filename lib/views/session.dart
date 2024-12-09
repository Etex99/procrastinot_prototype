import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/progress_bar.dart';
import 'package:procrastinot_prototype/components/task_list_item.dart';
import 'package:procrastinot_prototype/data/session.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class SessionView extends StatefulWidget {
  const SessionView({super.key});

  @override
  State<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  SessionManager? sessionManager;
  final List<bool> _taskDone = [false, false, false];

  @override
  void didChangeDependencies() {
    if (sessionManager == null) {
      SessionViewArgs args =
        ModalRoute.of(context)!.settings.arguments as SessionViewArgs;
      sessionManager = SessionManager(session: args.session);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Container bottomBar = Container(
      height: 100,
      color: MyTheme.BACKGROUND_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          // TODO: Exit button logic
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.door_back_door,
                size: 50,
                color: Colors.red,
              )),
          const SizedBox(width: 32,)
        ],
      ),
    );

    // enable / disable break button accordingly
    Function()? breakButtonFunc;
    if (sessionManager!.canTakeBreak()) {
      breakButtonFunc = () {
        sessionManager!.takeBreak(() => _returnFromBreak());
        Navigator.pushNamed(context, '/break', arguments: BreakViewArgs(sessionManager!.session.breakDuration));
      };
    }
    IconButton takeBreakButton = IconButton(
      icon: const Icon(Icons.coffee, size: 50,),
      onPressed: breakButtonFunc,
      color: MyTheme.ACCENT_COLOR,
      disabledColor: MyTheme.PRIMARY_COLOR_LIGHT,
    );

    // construct body column widgets
    List<Widget> bodyColumnChildren = [];
    for (var i = 0; i < 3; i++) {
      bodyColumnChildren.add(
        TaskListItem(taskLabel: sessionManager!.session.tasks![i], onPressed: () => _taskDone[i] = true,));
      if (i == 2) break;
      bodyColumnChildren.add(const SizedBox(height: 8));
    }
    bodyColumnChildren.add(const SizedBox(height: 16));
    bodyColumnChildren.add(Row(mainAxisSize: MainAxisSize.max, children: [takeBreakButton],));

    SessionProgressBar progressBar = SessionProgressBar(session: sessionManager!.session);

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  color: MyTheme.BACKGROUND_COLOR,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          progressBar
                        ],
                      ),
                    ),
                  ),
                )),
            Flexible(
                flex: 4,
                child: Container(
                  color: MyTheme.FOREGROUND_COLOR,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: bodyColumnChildren,
                    ))
                )),
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
  
  void _returnFromBreak() {
    Navigator.pop(context);
    setState(() {/* Rebuild view to update progress bar */});
  }
}

class SessionViewArgs {
  final Session session;

  SessionViewArgs(this.session);
}
