import 'dart:async';

class SessionManager {
  final Session session;

  final Stopwatch _stopwatch = Stopwatch();
  bool _onBreak = false;

  SessionManager({required this.session}) {
    _stopwatch.start();
  }

  void takeBreak(Function breakOverCallback) {
    _onBreak = true;
    session.elapsedTime += _stopwatch.elapsed;
    session.breaksTaken ++;
    _stopwatch.reset();
    Timer(session.breakDuration, () {
      _stopwatch.reset();
      _onBreak = false;
      breakOverCallback();
    });
  }

  void endSession() {
    _stopwatch.stop();
    if (!_onBreak) session.elapsedTime += _stopwatch.elapsed;
  }

  bool isOnBreak() => _onBreak;
}

class Session {

  Duration targetDuration;
  Duration breakDuration;
  int allowedBreaks;
  List<String>? tasks;

  Duration elapsedTime = const Duration();
  int breaksTaken = 0;

  Session({this.targetDuration = Duration.zero, this.breakDuration = Duration.zero, this.allowedBreaks = 0, this.tasks}) {
    tasks ??= ['', '', ''];
  }

  bool canTakeBreak() => breaksTaken < allowedBreaks;

  // All but breaks are mandatory.
  bool isValid() {
    if (targetDuration == Duration.zero) return false;
    if (tasks![0] == '') return false;
    if (tasks![1] == '') return false;
    if (tasks![2] == '') return false;
    return true;
  }
}