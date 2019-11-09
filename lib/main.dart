import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'services.dart';
import 'first.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
      runApp(MyApp());
    });
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: auth(), //check if user logged in or not
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            //if user is loggin first time then show login screen
            title: 'Flutter Demo',
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Nunito'),
            home: MyHomePage(title: 'Rao Infotech'),
          );
        } else {
          return MaterialApp(
            //if user already logged in redirect to second screen
            title: 'Flutter Demo',
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Nunito'),
            home: SecondScreen(value: snapshot.data),
          );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double radius = 5;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        //log in screen
        bottomSheet: Container(
          height: MediaQuery.of(context).size.height / 10,
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "2019 \u00a9 Rao InfoTech",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
        body: Container(
            child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                boxShadow: [BoxShadow(blurRadius: 20.0)],
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 100.0)),
              ),
            ),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .19,
                      right: 20.0,
                      left: 20.0),
                  child: Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: Colors.white,
                      elevation: 4.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: userNameController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person_outline),
                                  hintText: 'UserName',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(radius)))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock_open),
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(radius)))),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          SizedBox(
                              width: 200,
                              height: 50,
                              child: FlatButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    _login(userNameController.text,
                                        passwordController.text);
                                  },
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )))
                        ],
                      ),
                    ),
                  ),
                )),
            Container(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height /
                        1.4), //top: MediaQuery.of(context).size.height * 2),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "If you forget username/password then",
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("please contact admin",
                            style: TextStyle(fontSize: 17))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )));
  }

  _login(String uname, String password) async {
    print("in login");
    var response = await login(uname, password);
    final prefs = await SharedPreferences.getInstance();
    if (response != null) {
      var userId = response.id;
      var uName = response.name != null ? response.name : response.email;
      var email = response.email;
      prefs.setString('id', userId);
      prefs.setString('name', uName);
      prefs.setString('email', email); //store user id in localStorage
      var getStatus = await getAttendenceById();
      prefs.setString(
          'status', getStatus.status); //store status of user in localStorage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondScreen(value: userId)),
      );
    } else {
      print("in else");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Wrong email or password"),
          );
        },
      );
    }
  }
}
