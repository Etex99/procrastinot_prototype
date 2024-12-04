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
  late final SessionManager sessionManager;
  final List<bool> _taskDone = [false, false, false];

  markTaskDone(int index) {
    setState(() {
      _taskDone[index] = true;
    });
  }

  @override
  void didChangeDependencies() {
    SessionViewArgs args =
        ModalRoute.of(context)!.settings.arguments as SessionViewArgs;
    sessionManager = SessionManager(session: args.session);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Bottom bar
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

    // construct list of tasks
    List<Widget> tasks = [];
    for (var i = 0; i < 3; i++) {
      if (_taskDone[i] == false) {
        tasks.add(
          TaskListItem(taskLabel: sessionManager.session.tasks![i], onPressed: () => markTaskDone(i),)
        );
      } else {
        tasks.add(
          TaskListItem(taskLabel: sessionManager.session.tasks![i],)
        );
      }
      if (i == 2) break;
      tasks.add(const SizedBox(height: 8));
    }

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
                        SessionProgressBar(session: sessionManager.session)
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
                    children: tasks,
                  ))
              )),
          bottomBar
        ],
      ),
    ));
  }

  @override
  void dispose() {
    sessionManager.endSession();
    super.dispose();
  }
}

class SessionViewArgs {
  final Session session;

  SessionViewArgs(this.session);
}
