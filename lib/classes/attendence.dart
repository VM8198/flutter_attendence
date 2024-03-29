import 'package:json_annotation/json_annotation.dart';

class Attendence {
  @JsonKey(name: '_id')
  final String id;
  final String changes;
  final String status;
  final String difference;
  final String absentCount;
  final String uid;
  final String date;
  final String day;
  final List<TimeLog> timeLog;

  Attendence({
    this.id,
    this.changes,
    this.status,
    this.difference,
    this.absentCount,
    this.uid,
    this.date,
    this.day,
    this.timeLog
  });

  factory Attendence.fromJson(Map<String, dynamic> json) {
    var timeLogs = json['timeLog'] as List;
    List<TimeLog> finalLogs = timeLogs.map((i)=>TimeLog.fromJson(i)).toList();
    return Attendence(
      changes: json['changed'] as String,
      id: json['_id'] as String,
      status: json['status'] as String,
      difference: json['diffrence'] as String,
      day: json['day'] as String,
      absentCount: json['absentCount'] as String,
      //uid: json['userId'] as String,
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

class MultipleDaysLogs {
  final List multipleDaysLogs;
  final String totalHoursCompleted;
  final String totalHoursToComplete;

  MultipleDaysLogs({this.multipleDaysLogs, this.totalHoursCompleted, this.totalHoursToComplete});

   factory MultipleDaysLogs.fromJson(Map<String, dynamic> multiJson){
    var attendence = multiJson['foundLogs'].map((i)=>Attendence.fromJson(i)).toList();
      return MultipleDaysLogs(
        multipleDaysLogs: attendence,
        totalHoursCompleted: multiJson['TotalHoursCompleted'] as String,
        totalHoursToComplete: multiJson['TotalHoursToComplete'] as String
    );
  }
} 


