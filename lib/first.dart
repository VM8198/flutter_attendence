import 'package:attendence/showLogs.dart';
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
  void initState(){
    super.initState();
    getStatus(); //get status to check attendence filled or not
  }

  getStatus() async{
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('status');
    if(value == "Present"){
      setState(() {
       isClicked = false;
      });
    }else if(value == "Absent"){
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
      drawer: MyDrawer(), //call drawer
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        _fillAttendence();
                      },
                      child:
                          isClicked ? Text("Start") : Text("Stop"),
                    ),
                  ]),
                  //Table header
              Expanded(
                flex: 0,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width - 20,
                        child: Table(
                          border: TableBorder.all(color: Colors.black),
                          children: <TableRow>[
                            TableRow(children: <Widget>[
                              Container(
                                  height: 40,
                                  child: Center(
                                      child: Text("Date",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)))),
                              Container(
                                  height: 40,
                                  child: Center(
                                      child: Text("Day",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)))),
                              Container(
                                  height: 40,
                                  child: Center(
                                      child: Text("Hours",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)))),
                              Container(
                                  height: 40,
                                  child: Center(
                                      child: Text("Action",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))))
                            ])
                          ],
                        ))
                  ],
                ),
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
                      return ListView.builder( //List of last five days logs
                        itemBuilder: (context, position) {
                          return Table(
                            border: TableBorder.all(color: Colors.black),
                            children: <TableRow>[
                              TableRow(
                                children: <Widget>[
                                  Container(
                                      height: 30,
                                      child: Center(
                                          child: Text(
                                              logs[position]
                                                  .date
                                                  .toString()
                                                  .split("T")[0],
                                              textAlign: TextAlign.center))),
                                  Container(
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                            logs[position].day,
                                            textAlign: TextAlign.center),
                                      )),
                                  Container(
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                            logs[position]
                                                .difference,
                                            textAlign: TextAlign.center),
                                      )),
                                  Container(
                                      height: 30,
                                      child: Center(
                                          child: GestureDetector( //tap on view to show detailed logs
                                        onTap: () {
                                          openDialog(logs[position]
                                              .timeLog);
                                        },
                                        child: Text("View",
                                            textAlign: TextAlign.center),
                                      )))
                                ],
                              ),
                            ],
                          );
                        },
                        itemCount: logs.length, //show list till all data is not displayed
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
        return Material(
            child: SizedBox(
          // height: 100,
          // width: MediaQuery.of(context).size.width/50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //table header
              Expanded(
                flex: 0,
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50)),
                    Table(
                      children: <TableRow>[
                        TableRow(children: <Widget>[
                          Container(
                            height: 30,
                            child: Center(
                              child: Text("In",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                          ),
                          Container(
                            height: 30,
                            child: Center(
                              child: Text("Out",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                          )
                        ])
                      ],
                    )
                  ],
                ),
              ),
              //table data
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
                                        fontSize: 20, color: Colors.black))),
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
                itemCount: timeLog.length, //show list till all data is not displayed
              )),
            ],
          ),
        ));
      },
    );
  }
} 
