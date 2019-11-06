import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'services.dart';
import 'classes/attendence.dart';
import 'drawer.dart';
import 'style/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondScreen extends StatefulWidget {
  final String value;
  SecondScreen({Key key, this.value}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool isClicked = true;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    getStatus(); //get status to check attendence filled or not
  }

  getStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('status');
    if (value == "Present") {
      setState(() {
        isClicked = false;
      });
    } else if (value == "Absent") {
      setState(() {
        isClicked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendence'),
      ),
      drawer: MyDrawer(), //open drawer
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.indigo[300],
              Colors.indigo[200],
              Colors.indigo[100],
              Colors.indigo[50],
            ]
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.lightGreen[100],
                        textColor: Colors.indigo[800],
                        onPressed: () {
                          _fillAttendence();
                        },
                        child: isClicked
                            ? Text("Start TimeLog", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,),)
                            : Text("Stop TimeLog", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                    ]),
              ),              
              Expanded(
                child: Container(
                width: MediaQuery.of(context).size.width - 20,
                child: FutureBuilder<MultipleDaysLogs>(
                  future: _getMultipleDaysLogs(),  //get last five days logs
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) //if data is null then show loader
                      return SizedBox(
                          child: Center(child: ColorLoader3()),
                          height: 20,
                          width: 20);
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      List<dynamic> logs = data.multipleDaysLogs.reversed.toList(); 
                      var size = MediaQuery.of(context).size;   
                          final double itemHeight = size.height/2.3;
                          final double itemWidth = size.width;                  
                      return GridView.count(
                        crossAxisCount: 2,
                        padding: EdgeInsets.all(8.0),
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 5.0, 
                        childAspectRatio: (itemWidth/itemHeight),                       
                        children: List.generate(logs.length,(index) {
                          return Container(
                            child: GestureDetector(
                            onTap: () { openDialog(logs[index].timeLog); },
                            child: Card(
                            color: Colors.lightGreen[100],
                            elevation: 10,
                            child: Column(
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                                    child: Text(logs[index].date.toString().split("T")[0],
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.indigo[800]),
                                    ),
                                  )
                                ],),
                                Row(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(logs[index].day,
                                      style: TextStyle(fontSize: 15, color: Colors.indigo[800]),
                                    ),
                                  )
                                ],),
                                Row(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15, left: 8.0),
                                    child: Text("Total Hours :",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.indigo[800]),
                                    ),
                                  )
                                ],),
                                Row(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(logs[index].difference,
                                        style: TextStyle(fontSize: 15, color: Colors.indigo[800]),
                                      ),
                                  ),
                                ],),                                
                              ],
                          )
                          )));
                        }),
                      );
                    }
                  },
                ),
              ))                      
            ],
          ),
        ),
      ),
    );
  }

  Future<Attendence> _fillAttendence() async {
    var response = await fillAttendence();
    if (response != null) {
      setState(() {
        isClicked = !isClicked; //to change button if clicked or not
      });
      return response;
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Something went wrong"),
          );
        },
      );
    }
  }

  Future<MultipleDaysLogs> _getMultipleDaysLogs() async {
    var response = await getMultipleDaysLogs();
    if (response != null) {
      return response;
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Something went wrong"),
          );
        },
      );
    }
  }

  //show detaild logs
  Widget openDialog(List<TimeLog> timeLog) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(1), // background color
      barrierDismissible:
          true, // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog", // label for barrier
      transitionDuration: Duration(
          milliseconds:
              400), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        return Scaffold(
            appBar: AppBar(title: Text("Time Logs")),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.1, 0.5, 0.7, 0.9],
                      colors: [
                        Colors.indigo[300],
                        Colors.indigo[200],
                        Colors.indigo[100],
                        Colors.indigo[50],
                      ] 
                  )
                ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[],
                  ),
                  Expanded(
                    flex: 0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 50)),
                        Table(
                          children: <TableRow>[
                            TableRow(children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                height: 30,
                                child: Center(
                                  child: Text("In",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                height: 30,
                                child: Center(
                                  child: Text("Out",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black)),
                                ),
                              )
                            ])
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, position) {
                      return Table(
                        children: <TableRow>[
                          TableRow(
                            children: <Widget>[
                              Container(
                                height: 30,
                                child: Center(
                                    child: Text(timeLog[position].inTime,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black))),
                              ),
                              Container(
                                height: 30,
                                child: Center(
                                  child: Text(timeLog[position].outTime,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                    itemCount: timeLog.length,
                  )),
                ],
              ),
            )));
      },
    );
  }
}
