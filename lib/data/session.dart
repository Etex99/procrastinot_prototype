import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/storage/internal_storage.dart';

class SessionManager {
  static final SessionManager instance = SessionManager._internal();
  factory SessionManager() => instance;
  SessionManager._internal();
  
  Session session = Session();

  final Stopwatch _stopwatch = Stopwatch();

  Future<void> startSession() async {
    await InternalStorageHandler().setResumeSession(true);
    _stopwatch.start();
  }

  Future<void> endSession() async {
    await InternalStorageHandler().setResumeSession(false);
    _recordAndResetStopwatch();
    _stopwatch.stop();
  }

  void beginBreak() {
    _recordAndResetStopwatch();
    session.onBreak = true;
    session.breaksTaken ++;
  }

  void endBreak() {
    session.onBreak = false;
    session.elapsedBreakTime = Duration.zero;
    _stopwatch.reset();
  }

  void _recordAndResetStopwatch() {
    if (isOnBreak()) {
      session.elapsedBreakTime += _stopwatch.elapsed;
    } else {
      session.elapsedTime += _stopwatch.elapsed;
    }
    _stopwatch.reset();
  }

  bool isOnBreak() => session.onBreak;
  bool canTakeBreak() => session.breaksTaken < session.allowedBreaks;
  int getMinutesUntilTargetDuration() {
    _recordAndResetStopwatch();
    return session.targetDuration.inMinutes - session.elapsedTime.inMinutes;
  }
  int getMinutesUntilSuggestedBreak() {
    _recordAndResetStopwatch();
    int idealTimeWindowInMinutes = (session.targetDuration.inMinutes / (session.allowedBreaks + 1)).floor();
    int idealElapsedMinutes = idealTimeWindowInMinutes * (session.breaksTaken + 1);
    return idealElapsedMinutes - (session.elapsedTime.inMinutes).floor();
  }
  

  Future<void> preserveSession() async {
    InternalStorageHandler ish = InternalStorageHandler();
    await ish.setSessionSaveTimestamp(DateTime.timestamp());
    _recordAndResetStopwatch();
    await ish.saveSession(session);
    debugPrint('Preserved session: ${session}');
  }

  Future<void> restoreSession() async {
    InternalStorageHandler ish = InternalStorageHandler();
    
    session = await ish.loadSession();
    DateTime paused = await ish.getPausedTimestamp();
    DateTime now = DateTime.timestamp();
    Duration passedTime = now.difference(paused);


    if (isOnBreak()) {
      Duration passedMinusBreak = passedTime - (session.breakDuration - session.elapsedBreakTime);
      if (passedMinusBreak.isNegative) {
        //break is still ongoing
        session.elapsedBreakTime += passedTime;
      } else {
        //break ended during pause
        endBreak();
        session.elapsedTime += passedMinusBreak;
      }
    } else {
      session.elapsedTime += passedTime;
    }
    
    debugPrint('Restored session: ${session}');
  }

}

class Session {

  Duration targetDuration;
  Duration breakDuration;
  int allowedBreaks;
  List<String>? tasks;
  List<bool>? taskSuccess;

  bool onBreak;
  Duration elapsedTime = const Duration();
  Duration elapsedBreakTime = const Duration();
  int breaksTaken = 0;

  Session({this.targetDuration = Duration.zero, this.breakDuration = Duration.zero, this.allowedBreaks = 0, this.tasks, this.taskSuccess, this.onBreak = false}) {
    tasks ??= ['', '', ''];
    taskSuccess ??= [false, false, false];
  }

  Session.fromJson(Map<String, dynamic> json)
    : targetDuration = Duration(seconds: json["target_duration"] as int),
    breakDuration = Duration(seconds: json["break_duration"] as int),
    allowedBreaks = json["allowed_breaks"] as int,
    tasks = (json["tasks"] as List<dynamic>).cast<String>(),
    taskSuccess = (json["task_success"] as List<dynamic>).cast<bool>(),
    onBreak = json["on_break"] as bool,
    elapsedTime = Duration(seconds: json["elapsed_time"] as int),
    elapsedBreakTime = Duration(seconds: json["elapsed_break_time"] as int),
    breaksTaken = json["breaks_taken"] as int;

  Map<String, dynamic> toJson() => {
    "target_duration": targetDuration.inSeconds,
    "break_duration": breakDuration.inSeconds,
    "allowed_breaks": allowedBreaks,
    "tasks": tasks,
    "task_success": taskSuccess,
    "on_break": onBreak,
    "elapsed_time": elapsedTime.inSeconds,
    "elapsed_break_time": elapsedBreakTime.inSeconds,
    "breaks_taken": breaksTaken
  };

  // All but breaks are mandatory.
  bool isValid() {
    if (targetDuration == Duration.zero) return false;
    if (tasks![0] == '') return false;
    if (tasks![1] == '') return false;
    if (tasks![2] == '') return false;
    return true;
  }

  @override
  String toString() {
    String str = '{ target_duration: $targetDuration, ';
    str += 'break_duration: $breakDuration, ';
    str += 'allowed_breaks: $allowedBreaks, ';
    str += 'tasks: $tasks, ';
    str += 'task_success: $taskSuccess, ';
    str += 'on_break: $onBreak, ';
    str += 'elapsed_time: $elapsedTime, ';
    str += 'elapsed_break_time: $elapsedBreakTime, ';
    str += 'breaks_taken: $breaksTaken }';

    return str;
  }
}