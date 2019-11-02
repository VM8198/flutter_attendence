import 'package:flutter/material.dart';
import 'services.dart';
import 'first.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: auth(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Rao Infotech'),
          );
        } else {
          print("in main ====>"+snapshot.data);
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
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
  
  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();
    double radius = 5;
    return Scaffold(    
      backgroundColor: Colors.yellow[50],
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(5)),
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: 'UserName',
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(radius)))),
              ),
              Padding(padding: EdgeInsets.all(5)),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_open),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(radius)))),
              ),  
              Padding(padding: EdgeInsets.symmetric(vertical: 8),), 
              SizedBox(
                width: 200,
                height: 50,
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    _login(userNameController.text, passwordController.text);
                  },                  
                  child: Text("LOGIN", style: TextStyle(color: Colors.white,fontSize: 20),))
              )],
          ),
        ),
        
      ),
      
    );
   
  }

  _login(String uname, String password) async {
    print("in login");
    var response = await login(uname, password);
    final prefs = await SharedPreferences.getInstance();
    if (response != null) {
      var userId = response.id;
      prefs.setString('id', userId);
      var getStatus = await getAttendenceById();
      prefs.setString('status', getStatus.status);
      print("Login ma ================> "+getStatus.status);
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
            title: new Text("Wrong email or password"),
          );
        },
      );
    }
  }

 
}
