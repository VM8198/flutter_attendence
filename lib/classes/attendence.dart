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
  final List inTime;
  final List outTime;

  Attendence(
      {this.id,
      this.changes,
      this.status,
      this.difference,
      this.absentCount,
      this.userId,
      this.date,
      this.inTime,
      this.outTime});

  factory Attendence.fromJson(Map<String, dynamic> json) {
    return Attendence(
      changes: json['changes'] as String,
      id: json['_id'] as String,
      status: json['status'] as String,
      difference: json['difference'] as String,
      absentCount: json['absentCount'] as String,
      userId: json['userId'] as String,
      date: json['date'] as String,
      inTime: json['timeLog']['in'] as List,
      outTime: json['timeLog']['out'] as List
    );
  }
}
