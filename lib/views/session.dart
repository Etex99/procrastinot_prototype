import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/progress_bar.dart';
import 'package:procrastinot_prototype/data/session.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class SessionView extends StatefulWidget {


  const SessionView({super.key});

  @override
  State<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  late final SessionManager sessionManager;

  @override
  void didChangeDependencies() {
    SessionViewArgs args = ModalRoute.of(context)!.settings.arguments as SessionViewArgs;
    sessionManager = SessionManager(session: args.session);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
              color: MyTheme.FOREGROUND_COLOR,))
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