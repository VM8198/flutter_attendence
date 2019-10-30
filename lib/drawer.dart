import 'dart:developer';

import 'package:attendence/services.dart';
import 'package:flutter/material.dart';
import 'showLogs.dart';
import 'first.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class MyDrawer extends StatelessWidget {
//   bool value = false;
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               child: Text(""),
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/rao.png'),
//                   fit: BoxFit.none,
//             ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.dashboard,size: 30,color: Colors.black),
//               title: Text('Dashboard'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => SecondScreen()),
//                         );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.table_chart,size: 30,color: Colors.black),
//               title: Text('Logs summary'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => ShowLogs()),
//                         );
//               },
//             ),
//              ListTile(
//                leading: Icon(Icons.supervised_user_circle,size: 30,color: Colors.black),
//               title: Text('User Profile'),
//               onTap: () {
//                 Navigator.pop(context);

//               },
//             ),
//              ListTile(
//                leading: Icon(Icons.verified_user,size: 30,color: Colors.black),
//               title: Text('Log Out'),
//               onTap: () {
//                 Navigator.pop(context);
//                 FutureBuilder<String>(
//                     future: _logout(),
//                     builder: (BuildContext context, AsyncSnapshot snapshot) {
//                       print("===============>>>>>>>>>>>>"+snapshot.data.toString());
//                       if(snapshot.hasData){
//                         print("*******************************"+snapshot.data);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => MyApp()),
//                         );
//                       }if(!snapshot.hasData){
//                         print("&&&&&&&&&&&&&&&&&&&&&");
//                       }
//                     });
//               },
//             ),
//           ],
//         )
//     );
//   }

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
 @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(""),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/rao.png'),
              fit: BoxFit.none,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.dashboard, size: 30, color: Colors.black),
          title: Text('Dashboard'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.table_chart, size: 30, color: Colors.black),
          title: Text('Logs summary'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShowLogs()),
            );
          },
        ),
        ListTile(
          leading:
              Icon(Icons.supervised_user_circle, size: 30, color: Colors.black),
          title: Text('User Profile'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.verified_user, size: 30, color: Colors.black),
          title: Text('Log Out'),
          onTap: () {
            Navigator.pop(context);
            FutureBuilder<String>(
                future: _logout(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(
                      "===============>>>>>>>>>>>>" + snapshot.data.toString());
                  if (snapshot.hasData) {
                    print("*******************************" + snapshot.data);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  }
                  if (!snapshot.hasData) {
                    print("&&&&&&&&&&&&&&&&&&&&&");
                  }
                });
          },
        ),
      ],
    ));    
  }
    Future<String> _logout() async {
    print('in logout');
    String data = await logout();
    print(data);  
    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );  
    return data;
  } 
}

