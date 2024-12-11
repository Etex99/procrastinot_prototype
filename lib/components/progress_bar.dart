import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/data/session.dart';
import 'package:procrastinot_prototype/resources/theme.dart';
import 'package:procrastinot_prototype/util/format.dart';

class ProgressBar extends StatefulWidget {
  final Row iconRow;
  final Duration targetDuration;
  final Duration elapsedTime;
  const ProgressBar({super.key, required this.targetDuration, required this.elapsedTime, required this.iconRow});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller?.dispose();
    _controller = _startAnimation(widget.targetDuration, widget.elapsedTime);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget == widget) return;
    _controller?.dispose();
    _controller = _startAnimation(widget.targetDuration, widget.elapsedTime);
  }

  @override
  Widget build(BuildContext context) {
    LinearProgressIndicator progressBar = LinearProgressIndicator(
                  value: _controller!.value,
                  backgroundColor: MyTheme.PRIMARY_COLOR_LIGHT,
                  color: MyTheme.PRIMARY_COLOR,
                  minHeight: 25,
                );

    int elapsedMinutes = 0;
    if (0 < _controller!.value && _controller!.value <= 1) {
      elapsedMinutes = (widget.targetDuration.inMinutes * _controller!.value).floor();
    }
    String elapsedLabel;
    if (elapsedMinutes < widget.targetDuration.inMinutes) {
      elapsedLabel = MyFormatter.durationToString(Duration(minutes: elapsedMinutes));
    } else {
      elapsedLabel = "Overtime";
    }

    return Expanded(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.iconRow,
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: progressBar
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyBodyText(text: elapsedLabel)
              ],
            )
          ],
        ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  AnimationController _startAnimation(Duration targetDuration, Duration elapsedTime) {
    AnimationController ac = AnimationController(
        vsync: this, 
        duration: targetDuration,
        value: elapsedTime.inMilliseconds / targetDuration.inMilliseconds);
    ac.addListener(() => setState(() {}));
    ac.animateTo(targetDuration.inMilliseconds.toDouble());
    return ac;
  }
}

class SessionProgressBar extends StatelessWidget {
  final Session session;

  const SessionProgressBar({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    List<Widget> iconRowChildren = [];
    Icon usedBreak = const Icon(
      Icons.coffee,
      color: MyTheme.PRIMARY_COLOR_LIGHT,
      size: 25
    );
    Icon unusedBreak = const Icon(
      Icons.coffee,
      color: MyTheme.PRIMARY_COLOR,
      size: 25
    );
    for (var i = 0; i < session.breaksTaken; i++) {
      iconRowChildren.add(const Spacer());
      iconRowChildren.add(usedBreak);
    }
    for (var i = 0; i < (session.allowedBreaks - session.breaksTaken); i++) {
      iconRowChildren.add(const Spacer());
      iconRowChildren.add(unusedBreak);
    }
    iconRowChildren.add(const Spacer());
    iconRowChildren.add(const Icon(
      Icons.celebration,
      color: MyTheme.PRIMARY_COLOR,
      size: 25
    ));
    Row iconRow = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: iconRowChildren,
    );

    return ProgressBar(targetDuration: session.targetDuration, elapsedTime: session.elapsedTime, iconRow: iconRow);
  }
}

class BreakProgressBar extends StatelessWidget {
  final Duration duration;
  const BreakProgressBar({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    Row iconRow = const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.book,
          color: MyTheme.PRIMARY_COLOR,
          size: 25,
        )
      ],
    );
    return ProgressBar(targetDuration: duration, elapsedTime: Duration.zero, iconRow: iconRow);
  }
}
