import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'classes/user.dart';
import 'classes/attendence.dart';

const baseUrl = 'https://attendence.raoinformationtechnology.com:4000/';
// const baseUrl = 'http://192.168.1.50:4000/';

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

Future fillAttendence(String userId) async {
  print("=======>" + "in service uid" + userId);
  var body = {userId: userId};
  var response = await http.post(baseUrl + "attendance/fill-attendance", body: body);
  print("response"+response.toString());
  if(response.statusCode == 200){
    print("Positive response");
    var jsonResponse = json.decode(response.body);
    var attendence = Attendence.fromJson(jsonResponse);
    return attendence;
  }else{
    return null;
  }
}
