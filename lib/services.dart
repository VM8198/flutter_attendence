import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'classes/user.dart';
import 'classes/attendence.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const baseUrl = 'https://attendence.raoinformationtechnology.com:4000/';
//  const baseUrl = 'http://192.168.1.50:5000/';
const baseUrl = 'http://192.168.1.39:4000/';

Future login(String uname, String password) async {
  var body = {'email': uname, 'password': password};
  try {
    print(body);
    var response = await http.post(baseUrl + 'user/login', body: body);
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      print(statusCode);
      var jsonResponse = json.decode(response.body);
      var user = User.fromJson(jsonResponse);
      return user;
    } else {
      return null;
    }
  } catch (error) {
    print(error);
  }
}

Future<String> logout() async{
  print("in logout service");
  final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return "log out successfully";
}

Future<Attendence> fillAttendence() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('id');
  var body = {'userId': userId};
  print("body==============>  "+body.toString());
  var response = await http.post(baseUrl + "attendance/fill-attendance", body: body);
  if(response.statusCode == 200){
    var jsonResponse = json.decode(response.body);
    var attendence = Attendence.fromJson(jsonResponse[0]);
    prefs.setString('status', attendence.status);
    return attendence;
  }else{
    return null;
  }
}

Future<String> auth() async{
  print("+++++++++++++++++++++++++in auth function");
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getString('id');
  print("+++++++++++"+value);
  if(value != null) return value;
  else return null;
}

Future<Attendence> getAttendenceById() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('id');    
  var body = {'userId': userId};  
  var response = await http.post(baseUrl + "attendance/get-attendance-by-id", body: body);
  if(response.statusCode == 200){
    var jsonResponse = json.decode(response.body);
    var attendence = Attendence.fromJson(jsonResponse[0]);
    return attendence;
  }else return null;
}

Future<MultipleDaysLogs> getMultipleDaysLogs() async{
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('id');
  var body = {'userId': userId, 'days': '5'};  
  var response = await http.post(baseUrl + "attendance/get-attendance-by-id", body: body);
  if(response.statusCode == 200){
    var jsonResponse = json.decode(response.body);
    var multipleDaysLogs = MultipleDaysLogs.fromJson(jsonResponse);
    print(multipleDaysLogs);
    return multipleDaysLogs; 
  }else return null;
}

Future<MultipleDaysLogs> getDateWiseLogs(DateTime d1,DateTime d2) async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('id');
  var body = {'userId ': userId, 'startDate': d1, 'endDate': d2, 'flag': 'true'};
  var response = await http.post(baseUrl + "attendance/get-report-by-id", body: body);
  if(response.statusCode == 200){
    var jsonResponse = json.decode(response.body);
    var logs = MultipleDaysLogs.fromJson(jsonResponse);
    return logs;
  }else{
    print("in else");
    return null;
  }
}

Future<MultipleDaysLogs> getDateWiseLogsString(String d1,String d2) async {
  print("last days service");
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('id');
  var body = {'userId': userId, 'startDate': d1, 'endDate': d2, 'flag': 'true'};
  print(body);
  var response = await http.post(baseUrl + "attendance/get-report-by-id", body: body);
  if(response.statusCode == 200){
   print(response.body);
    var jsonResponse = json.decode(response.body);
    var logs = MultipleDaysLogs.fromJson(jsonResponse);
    print("hal hve");
    print(logs);
    return logs;
  }else{
    print("in else");
    return null;
  }
}
















/*
new res
{"foundLogs":[{"changed":null,"status":"Present","diffrence":"00:35:35","absentCount":"2",
"_id":"5dba68afb06bed1185b66253","day":"Thursday",
"userId":{"userRole":"employee","_id":"5d92eda76b6aa2362ba8aa1c","email":"pushpraj4132@gmail.com",
"name":"pushpraj","designation":"mean stack developer","password":"123456789","__v":0},
"date":"2019-10-31T18:30:00.000Z",
"timeLog":[{"in":"10:23:03 am","out":"10:58:36 am"},{"in":"10:58:41 am","out":"10:58:43 am"}
,{"in":"10:58:44 am","out":"-"}],"__v":0}],
"TotalHoursCompleted":"0:35:00","TotalHoursToComplete":"42:30:00"}
*/