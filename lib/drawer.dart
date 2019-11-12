import 'package:attendence/services.dart';
import 'package:attendence/style/loader.dart';
import 'package:flutter/material.dart';
import 'showLogs.dart';
import 'first.dart';
import 'main.dart';
import 'profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key key}) : super(key: key);
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
        Container(
          child: FutureBuilder<List>(
            future: getUserNameAndEmail(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return ColorLoader3();
              }
              if(snapshot.hasData){
                return UserAccountsDrawerHeader(
                    accountName: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 5),
                      child: Text(snapshot.data[0], style: TextStyle(fontSize: 20),),
                    ),
                    accountEmail: Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 0.0),
                      child: Text(snapshot.data[1], style: TextStyle(fontSize: 15),),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://ui-avatars.com/api/?name='+snapshot.data[0]+'&color=0000ff&bold=true'),
                    ),
                );
                // return DrawerHeader(
                //   decoration: BoxDecoration(
                //     color: Colors.blue,
                //     image: DecorationImage(
                //       image: AssetImage("assets/images/profile.png"),
                //       fit: BoxFit.fitWidth
                //     )
                //   ),
                //   child: Container(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: <Widget>[
                //       Row(
                //         children: <Widget>[
                //           Text(snapshot.data[0])
                //         ],
                //       ),
                //       Row(
                //         children: <Widget>[
                //           Text(snapshot.data[1])
                //         ],
                //       )
                //     ],
                //   ),
                // )
                // );
              }
            },
          ) 
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
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnimatedContainerApp()),
            );
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
                  if (snapshot.hasData) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  }
                  if (!snapshot.hasData) {
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

  Future<List> getUserNameAndEmail() async {
    final prefs = await SharedPreferences.getInstance();
    var uName = prefs.getString('name');
    var email = prefs.getString('email');
    List<String> userData = new List<String>();
    userData.add(uName);
    userData.add(email);
    return userData;
  }
}

 