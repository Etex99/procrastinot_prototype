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

class BreakProgressBar extends StatefulWidget {
  const BreakProgressBar({super.key});

  @override
  State<BreakProgressBar> createState() => _BreakProgressBarState();
}

class _BreakProgressBarState extends State<BreakProgressBar> with TickerProviderStateMixin {
  Duration? _duration;
  AnimationController? controller;

  @override
  void didChangeDependencies() {
    if (_duration == null) {
      BreakViewArgs args =
        ModalRoute.of(context)!.settings.arguments as BreakViewArgs;
      _duration = args.d;
      controller = AnimationController(
        vsync: this, 
        duration: _duration,
        value: 0);
      controller!.addListener(() => setState(() {}));
      controller!.animateTo(1);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

class BreakViewArgs {
  final Duration d;
  BreakViewArgs(this.d);
}
