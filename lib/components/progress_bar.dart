import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/data/session.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class SessionProgressBar extends StatefulWidget {
  final Session session;

  const SessionProgressBar(
      {super.key,
      required this.session});

  @override
  State<SessionProgressBar> createState() => _SessionProgressBarState();
}

class _SessionProgressBarState extends State<SessionProgressBar>
    with TickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    controller = _startNewAnimation(widget.session);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SessionProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller!.dispose();
    controller = _startNewAnimation(widget.session);
  }

  AnimationController _startNewAnimation(Session s) {
    AnimationController res = AnimationController(
        vsync: this, 
        duration: s.targetDuration,
        value: s.elapsedTime.inMilliseconds / s.targetDuration.inMilliseconds);
    res.addListener(() => setState(() {}));
    res.animateTo(s.targetDuration.inMilliseconds.toDouble());
    return res;
  }

  @override
  Widget build(BuildContext context) {

    // Construct row of icons by spacing breaks evenly
    List<Widget> iconRowChildren = [];
    for (var i = 0; i < widget.session.allowedBreaks; i++) {
      iconRowChildren.add(const Spacer(flex: 1));
      iconRowChildren.add(const Icon(
        Icons.coffee,
        color: MyTheme.PRIMARY_COLOR_LIGHT,
        size: 25,
      ));
    }
    iconRowChildren.add(const Spacer(flex: 1));
    iconRowChildren.add(const Icon(
      Icons.celebration,
      color: MyTheme.PRIMARY_COLOR_LIGHT,
      size: 25,
    ));

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: iconRowChildren
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: LinearProgressIndicator(
                  value: controller!.value,
                  backgroundColor: MyTheme.PRIMARY_COLOR_LIGHT,
                  color: MyTheme.PRIMARY_COLOR,
                  minHeight: 25,
                ),
              ),
            ],
          ),
         
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
