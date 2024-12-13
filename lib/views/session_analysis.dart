import 'dart:async';
import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/app_bar.dart';
import 'package:procrastinot_prototype/components/suggestion.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class SessionAnalysis extends StatefulWidget {
  const SessionAnalysis({super.key});

  @override
  State<SessionAnalysis> createState() => _SessionAnalysisState();
}

class _SessionAnalysisState extends State<SessionAnalysis> {
  int _choice = 0;
  bool _canExit = false;

  void _choose(int i) {
    setState(() {
      _choice = i;
    });
    Timer(const Duration(seconds: 5), () {
      setState(() {
        _canExit = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> bodyContentChildren = [];

    if (_choice == 0) {
      Widget choicesBar = Container(
        color: MyTheme.FOREGROUND_COLOR,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyElevatedButton(text: 'Procrastination', onPressed: () => _choose(1)),
            const VerticalDivider(color: MyTheme.PRIMARY_COLOR,),
            MyElevatedButton(text: 'Insufficient Time', onPressed: () => _choose(2))
          ],
        ),
      );
      bodyContentChildren.add(choicesBar);
    }
    
    switch (_choice) {
      case 0:
        // No choice yet
        bodyContentChildren.add(const MySubtitle(
            text: 'Choose the most fitting challenge you faced this session.'));
        break;
      case 1:
        // Choice: Procrastination
        bodyContentChildren.add(const ProcrastinationSuggestion());
        break;
      case 2:
        // Choice: Out of time
        bodyContentChildren.add(const OutOfTimeSuggestion());
        break;
      default:
        bodyContentChildren.add(const MyBodyText(text: '...'));
    }
    Widget bodyContent = Expanded(
      child: Container(
        color: MyTheme.FOREGROUND_COLOR,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: bodyContentChildren,),
        ),
      ),
    );

    Function()? exitOnClick;
    if (_canExit) exitOnClick = () => Navigator.pushReplacementNamed(context, "/home");
    Widget bottomBar = Container(
        color: MyTheme.BACKGROUND_COLOR,
        height: 100,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: exitOnClick,
              icon: MyTheme.DOOR,
              disabledColor: MyTheme.PRIMARY_COLOR_LIGHT,
              color: Colors.red
            ),
            const SizedBox(
              width: 8.0,
            )
          ],
        ));

    return SafeArea(
        child: Scaffold(
      appBar: MyAppBar('Session Insights'),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [bodyContent, bottomBar],
      ),
    ));
  }
}
