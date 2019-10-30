import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'classes/user.dart';
import 'classes/attendence.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const baseUrl = 'https://attendence.raoinformationtechnology.com:4000/';
 const baseUrl = 'http://192.168.1.50:5000/';
// const baseUrl = 'http://192.168.1.39:4000/';

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

Future<Attendence> fillAttendence(String userId) async {
  var body = {'userId': userId};
  print("body==============>  "+body.toString());
  var response = await http.post(baseUrl + "attendance/fill-attendance", body: body);
  if(response.statusCode == 200){
    var jsonResponse = json.decode(response.body);
    print("++++++++++++"+response.body.toString());
    var attendence = Attendence.fromJson(jsonResponse[0]);
    return attendence;
  }else{
    return null;
  }
}

Future<String> auth() async{
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getString('id');
  print("+++++++++++"+value);
  if(value != null) return value;
  else return null;
}

Future<Attendence> getAttendenceById(String userId) async {    
  var body = {'userId': userId};  
  var response = await http.post(baseUrl + "attendance/get-attendance-by-id", body: body);
  if(response.statusCode == 200){
    var jsonResponse = json.decode(response.body);
    var attendence = Attendence.fromJson(jsonResponse[0]);
    return attendence;
  }else return null;
}

Future<MultipleDaysLogs> getMultipleDaysLogs(String userId) async{
  var body = {'userId': userId, 'days': '5'};  
  print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  var response = await http.post(baseUrl + "attendance/get-attendance-by-id", body: body);
  if(response.statusCode == 200){
    var jsonResponse = json.decode(response.body);
    var multipleDaysLogs = MultipleDaysLogs.fromJson(jsonResponse);
    return multipleDaysLogs; 
  }else return null;
}

Future<MultipleDaysLogs> getDateWiseLogs(String userId,DateTime d1,DateTime d2) async {
  print("last days service");
  var body = {'userId ': userId, 'startDate': d1, 'endDate': d2, 'flag': 'true'};
  print(body);
  print("Hello World !!");
  var response = await http.post(baseUrl + "attendance/get-report-by-id", body: body);
  print("-----------------------------------------------------------");
  if(response.statusCode == 200){
    print("aaivo aaivo");
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

Future<MultipleDaysLogs> getDateWiseLogsString(String userId,String d1,String d2) async {
  print("last days service");
  var body = {'userId': userId, 'startDate': d1, 'endDate': d2, 'flag': 'true'};
  print(body);
  var response = await http.post(baseUrl + "attendance/get-report-by-id", body: body);
  if(response.statusCode == 200){
    // print("aaivo aaivo");
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
















      // Center(
        // child: Container(
        //   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        //   child: Center(
        //   child: Column(
        //   children: <Widget>[
        //     FlatButton(
        //         color: Colors.blue,
        //         onPressed: () {
        //           _fillAttendence(widget.value);
        //         },
        //         child: Text("Fill Attenedence")
        //         ),
        //         // Column()
        //         Table(                
        //           border: TableBorder.all(color: Colors.black),
        //           children: <TableRow>[
        //             TableRow(
        //               children: <Widget>[
        //                 FittedBox(
        //                   child: Center(
        //                     child: Text("Date",
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                       color: Colors.black,
        //                       fontSize: 1,
        //                       )
        //                     ),
        //                   ),
        //                 ),
        //                 FittedBox(
        //                   child: Center(
        //                     child: Text("Day",
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                       color: Colors.black,
        //                       fontSize: 1,
        //                       )
        //                     ),
        //                   ),
        //                 ),
        //                 FittedBox(
        //                   child: Center(
        //                     child: Text("Hours \n in \n office",
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                       color: Colors.black,
        //                       fontSize: 1,
        //                       )
        //                     ),
        //                   ),
        //                 ),
        //                 FittedBox(
        //                   child: Center(
        //                     child: Text("Action",
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                       color: Colors.black,
        //                       fontSize: 1,
        //                       )
        //                     ),
        //                   ),
        //                 ),
        //               ]
        //             ),
        //             TableRow(
        //               children: <Widget>[
        //                 FittedBox(
        //                   child: Center(
        //                     child: Text("17-10-2019",
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                       color: Colors.black,
        //                       fontSize: 1,
        //                       )
        //                     ),
        //                   ),
        //                 ),
        //                 FittedBox(
        //                   child: Center(
        //                     child: Text("Thursday",
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                       color: Colors.black,
        //                       fontSize: 1,
        //                       )
        //                     ),
        //                   ),
        //                 ),
        //                 FittedBox(
        //                   child: Center(
        //                     child: Text("5:00",
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                       color: Colors.black,
        //                       fontSize: 1,
        //                       )
        //                     ),
        //                   ),
        //                 ),
        //                 FittedBox(
        //                   child: Center(
        //                     child: Text("View",
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                       color: Colors.black,
        //                       fontSize: 1,
        //                       )
        //                     ),
        //                   ),
        //                 ),
        //               ] 
        //             )
        //           ],
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      //),