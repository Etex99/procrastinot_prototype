import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/data/session.dart';

class SessionView extends StatelessWidget {

  const SessionView({super.key});

  @override
  Widget build(BuildContext context) {
    
    SessionViewArgs args = ModalRoute.of(context)!.settings.arguments as SessionViewArgs;

    return SafeArea(child: Scaffold(body: Column(
      children: [
        Text(args.session.targetDuration.toString()),
        Text(args.session.breakDuration.toString()),
        Text(args.session.allowedBreaks.toString()),
        Text(args.session.tasks![0].toString()),
        Text(args.session.tasks![1].toString()),
        Text(args.session.tasks![2].toString()),
      ],
    )));

  }

}

class SessionViewArgs {

  final Session session;

  SessionViewArgs(this.session);

}