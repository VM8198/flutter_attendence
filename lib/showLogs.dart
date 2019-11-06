import 'package:flutter/material.dart';
import 'classes/attendence.dart';
import 'services.dart';
import 'drawer.dart';
import 'style/loader.dart';

class ShowLogs extends StatefulWidget {
  final Future<String> value;
  ShowLogs({
    Key key,
    this.value,
  }) : super(key: key);
  @override
  _ShowLogsState createState() => _ShowLogsState();
}

class _ShowLogsState extends State<ShowLogs> {
  DateTime selectedDate1 = DateTime.now(); //assign todays date to both dates
  DateTime selectedDate2 = DateTime.now();
  String worked = '';
  String toWork = '';
  bool flag = false;
  bool isDate1Selected = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; 
                                final double itemHeight = size.height/2.3;
                          final double itemWidth = size.width;
    return Scaffold(
        appBar: AppBar(title: Text("Logs Summary"),),
        drawer: MyDrawer(),
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
              children: <Widget>[
                Expanded(
                    flex: 0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.lightGreen[100],
                                textColor: Colors.lightGreen[100],
                                onPressed: () {
                                  _selectDate1(context);
                                },
                                child: Text("Select date 1", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.indigo[800])),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                              ),
                              IgnorePointer(
                                //if date 1 is not selected then it is disabled
                                ignoring: isDate1Selected ? false : true,
                                child: RaisedButton(
                                  color:Colors.lightGreen[100],
                                  textColor: Colors.blueAccent,
                                  onPressed: () {
                                    _selectDate2(context);
                                  },
                                  child: Text("Select date 2", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.indigo[800])),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: FutureBuilder(
                            future: _getLogsString(
                                selectedDate1.toString().split(" ")[0],
                                selectedDate2.toString().split(" ")[0]),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Text("Total hours to work : ",
                                          style: TextStyle(
                                              color: Colors.grey[50],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                      ),
                                      Text("Total hours worked : ",
                                          style: TextStyle(
                                              color: Colors.grey[50],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))
                                    ],
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                 
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Text("Total hours to work : " + toWork,
                                          style: TextStyle(
                                              color: Colors.grey[50],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                      ),
                                      Text("Total hours worked : " + worked,
                                          style: TextStyle(
                                              color: Colors.grey[50],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        )
                      ],
                    )),
                Expanded(
                    child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  child: FutureBuilder<MultipleDaysLogs>(
                    future: flag
                        ? _getLogsString(selectedDate1.toString().split(" ")[0],
                            selectedDate2.toString().split(" ")[0])
                        : _getMultipleDaysLogs(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData)
                        return SizedBox(
                            child: Center(child: ColorLoader3()),
                            height: 20,
                            width: 20);
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        List<dynamic> logs =
                            data.multipleDaysLogs.reversed.toList();
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
        ));
  }

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
              width: MediaQuery.of(context).size.width - 20,
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
            ));
      },
    );
  }

  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate1,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate1) {
      selectedDate1 = picked;
      setState(() {
        isDate1Selected = true;
      });
    }
  }

  Future<Null> _selectDate2(BuildContext context) async {
    if (selectedDate1 != null) {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate2,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate2) selectedDate2 = picked;
      setState(() {
        flag = true;
        isDate1Selected = false;
      });
    }
  }

  Future<MultipleDaysLogs> _getMultipleDaysLogs() async {
    var response = await getMultipleDaysLogs();
    if (response != null) {
      worked = response.totalHoursCompleted;
      toWork = response.totalHoursToComplete;
      return response;
    } else {
      print("in else");
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

  Future<MultipleDaysLogs> _getLogsString(String date1, String date2) async {
    var response = await getDateWiseLogsString(date1, date2);
    if (response != null) {
      worked = response.totalHoursCompleted;
      toWork = response.totalHoursToComplete;
      return response;
    } else {
      print("in else");
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
}
