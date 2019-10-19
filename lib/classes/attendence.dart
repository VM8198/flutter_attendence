import 'package:json_annotation/json_annotation.dart';

class Attendence {
  @JsonKey(name: '_id')
  final String id;
  final String changes;
  final String status;
  final String difference;
  final String absentCount;
  final String userId;
  final String date;
  final String day;
  final List<TimeLog> timeLog;

  Attendence({
    this.id,
    this.changes,
    this.status,
    this.difference,
    this.absentCount,
    this.userId,
    this.date,
    this.day,
    this.timeLog
  });

  factory Attendence.fromJson(Map<String, dynamic> json) {
    var timeLogs = json['timeLog'] as List;
    List<TimeLog> finalLogs = timeLogs.map((i)=>TimeLog.fromJson(i)).toList();
    return Attendence(
      changes: json['changes'] as String,
      id: json['_id'] as String,
      status: json['status'] as String,
      difference: json['difference'] as String,
      day: json['day'] as String,
      absentCount: json['absentCount'] as String,
      userId: json['userId'] as String,
      date: json['date'] as String,
      timeLog: finalLogs
    );
  }
}

class TimeLog {
  final String inTime;
  final String outTime;

  TimeLog({this.inTime, this.outTime});

  factory TimeLog.fromJson(Map<String, dynamic> jsonTime) {
    return TimeLog(
        inTime: jsonTime['in'] as String, 
        outTime: jsonTime['out'] as String
      );
  }
}
