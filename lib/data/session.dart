import 'package:procrastinot_prototype/storage/internal_storage.dart';

class SessionManager {
  static final SessionManager instance = SessionManager._internal();
  factory SessionManager() => instance;
  SessionManager._internal();
  
  Session session = Session();

  final Stopwatch _stopwatch = Stopwatch();

  void startSession() {
    _stopwatch.start();
  }

  void beginBreak() {
    session.onBreak = true;
    session.elapsedTime += _stopwatch.elapsed;
    session.breaksTaken ++;
    _stopwatch.stop();
    _stopwatch.reset();
  }

  void endBreak() {
    _stopwatch.start();
    session.onBreak = false;
  }

  void stopSession() {
    session.elapsedTime += _stopwatch.elapsed;
    _stopwatch.stop();
    _stopwatch.reset();
  }

  bool isOnBreak() => session.onBreak;
  bool canTakeBreak() => session.breaksTaken < session.allowedBreaks;
  int getTimeDifference() {
    session.elapsedTime += _stopwatch.elapsed;
    return session.targetDuration.inMinutes - session.elapsedTime.inMinutes;
  }

  // used when app is paused or killed
  Future<void> pauseSession() async {
    InternalStorageHandler ish = InternalStorageHandler();
    await ish.setResumeSession(true);
    await ish.setPausedTimestamp(DateTime.timestamp());
    
    stopSession();
    await ish.saveSession(session);
  }
  Future<bool> resumeSession() async {
    InternalStorageHandler ish = InternalStorageHandler();
    await ish.setResumeSession(false);
    
    session = await ish.loadSession();

    // TODO: perform correct actions if app was paused during break...
    // how much actual worktime elapsed?
    
    DateTime paused = await ish.getPausedTimestamp();
    DateTime now = DateTime.timestamp();
    Duration passedTime = now.difference(paused);
    session.elapsedTime += passedTime;

    // for now subtract entire break...
    if (session.onBreak == true) {
      session.elapsedTime -= session.breakDuration;
      if (session.elapsedTime.isNegative) session.elapsedTime = Duration.zero;
      session.onBreak = false;
    }

    startSession();
    return true;
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
    breaksTaken = json["breaks_taken"] as int;

  Map<String, dynamic> toJson() => {
    "target_duration": targetDuration.inSeconds,
    "break_duration": breakDuration.inSeconds,
    "allowed_breaks": allowedBreaks,
    "tasks": tasks,
    "task_success": taskSuccess,
    "on_break": onBreak,
    "elapsed_time": elapsedTime.inSeconds,
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
    str += 'breaks_taken: $breaksTaken }';

    return str;
  }
}