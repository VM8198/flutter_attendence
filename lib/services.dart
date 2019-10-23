import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'classes/user.dart';
import 'classes/attendence.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const baseUrl = 'https://attendence.raoinformationtechnology.com:4000/';
 const baseUrl = 'http://192.168.1.50:5000/';

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
  var body = {userId: userId};
  var response = await http.post(baseUrl + "attendance/fill-attendance", body: body);
  if(response.statusCode == 200){
    var jsonResponse = json.decode(response.body);
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
  var body = {userId: userId};  
  var response = await http.post(baseUrl + "attendance/get-attendance-by-id", body: body);
  if(response.statusCode == 200){
    var jsonResponse = json.decode(response.body);
    var attendence = Attendence.fromJson(jsonResponse[0]);
    return attendence;
  }else return null;
}

Future<MultipleDaysLogs> getMultipleDaysLogs(String userId) async{
  var body = {userId: userId, 'days': '5'};  
  var response = await http.post(baseUrl + "attendance/get-attendance-by-id", body: body);
  if(response.statusCode == 200){
    var jsonResponse = json.decode(response.body);
    var multipleDaysLogs = MultipleDaysLogs.fromJson(jsonResponse);
    return multipleDaysLogs; 
  }else return null;
}

// Future<Attendence> getLastFiveDaysLogs(String userId) async {
//   print("last days service");
//   var body = {"userId": userId, "days": 5};
//   var response = await http.post(baseUrl + "attendance/get-attendance-by-id", body: body);
//   if(response.statusCode == 200){
//     print("in last days.............");
//     var jsonResponse = json.decode(response.body);
//     var attendence = Attendence.fromJson(jsonResponse[0]);
//     print("yes returning...."+attendence.toString());
//     return attendence;
//   }else{
//     print("in else");
//     return null;
//   }
// }
















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