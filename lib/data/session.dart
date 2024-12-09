import 'dart:async';

class SessionManager {
  final Session session;

  final Stopwatch _stopwatch = Stopwatch();
  bool _onBreak = false;

  SessionManager({required this.session}) {
    _stopwatch.start();
  }

  void beginBreak() {
    _onBreak = true;
    session.elapsedTime += _stopwatch.elapsed;
    session.breaksTaken ++;
    _stopwatch.stop();
    _stopwatch.reset();
  }

  void endBreak() {
    _stopwatch.start();
    _onBreak = false;
  }

  void endSession() {
    _stopwatch.stop();
    if (!_onBreak) session.elapsedTime += _stopwatch.elapsed;
  }

  bool isOnBreak() => _onBreak;
  bool canTakeBreak() => session.breaksTaken < session.allowedBreaks;
  int getTimeDifference() {
    session.elapsedTime += _stopwatch.elapsed;
    return session.targetDuration.inMinutes - session.elapsedTime.inMinutes;
  }
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

  // All but breaks are mandatory.
  bool isValid() {
    if (targetDuration == Duration.zero) return false;
    if (tasks![0] == '') return false;
    if (tasks![1] == '') return false;
    if (tasks![2] == '') return false;
    return true;
  }
}