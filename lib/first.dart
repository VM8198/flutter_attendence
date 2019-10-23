import 'package:attendence/showLogs.dart';
import 'package:flutter/material.dart';
import 'services.dart';
import 'classes/attendence.dart';

class SecondScreen extends StatefulWidget {
  final String value;
  SecondScreen({Key key, this.value}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool isClicked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Attendence'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                
                  RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        this.setState(() => isClicked = !isClicked);
                           _fillAttendence(widget.value);
                      },
                      child: isClicked ? Text("Fill Attendence") : Text("Remove"),
                  ),                  
                
                Expanded(
                  flex: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 340,
                        child: Table(
                        border: TableBorder.all(color: Colors.black),
                        children: <TableRow>[
                          TableRow(children: <Widget>[
                            Container(
                              height: 40,
                              child: Center(
                                child: Text("Date", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                                )
                              ),
                            Container(
                              height: 40,
                              child: Center(
                                child: Text("Day", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                                )
                              ),
                            Container(
                              height: 40,
                              child: Center(
                                child: Text("Hours", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                                )
                              ),
                            Container(
                              height: 40,
                              child: Center(
                                child: Text("Action", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                                )
                              )
                          ])
                        ],
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 340,
                    child: FutureBuilder<MultipleDaysLogs>(
                    future: _getMultipleDaysLogs(widget.value),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData)
                        return SizedBox(
                            child: Center(child: CircularProgressIndicator()),
                            height: 20,
                            width: 20);
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        // data.add(snapshot.data.multipleDaysLogs);
                        print("======================>1234"+snapshot.data.multipleDaysLogs[0].date.toString());
                        return ListView.builder(
                          itemBuilder: (context, position) {
                            return Table(
                              border: TableBorder.all(color: Colors.black),
                              children: <TableRow>[
                                TableRow(
                                  children: <Widget>[
                                    Container(
                                      height: 30,                                       
                                      child: Center(child:  
                                      Text(data.multipleDaysLogs[position].date.toString().split("T")[0],
                                          textAlign: TextAlign.center)
                                    )),
                                    Container(height: 30,child:Center(child:  
                                    Text(data.multipleDaysLogs[position].day,
                                        textAlign: TextAlign.center),
                                    )),
                                    Container(height: 30, child: Center(child:  
                                    Text(data.multipleDaysLogs[position].difference,
                                        textAlign: TextAlign.center),
                                    )),
                                    Container(height: 30,child: Center(child:  
                                    GestureDetector(
                                      onTap: () {
                                        openDialog(data.multipleDaysLogs[position].timeLog);
                                      },
                                      child: Text("View",
                                          textAlign: TextAlign.center),
                                    )))
                                  ],
                                ),
                              ],
                            );
                          },
                          itemCount: data.multipleDaysLogs.length,
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

  Future<Attendence> _fillAttendence(String userId) async {
    var response = await fillAttendence(userId);
    print("FILL ATTENDENCE");
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

  Future<Attendence> _getAttendenceById(String userId) async {
    var response = await getAttendenceById(userId);
    if (response != null) {
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

  Future<MultipleDaysLogs> _getMultipleDaysLogs(String userId) async{
    var response = await getMultipleDaysLogs(userId);
    if (response != null) {      
       print("response"+response.toString());
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
         child: SizedBox.expand(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 0,
                child: Column(
                  children: <Widget>[                    
                    Padding(padding: EdgeInsets.all(24)),
                    Table(
                      border: TableBorder.all(color: Colors.black),
                      children: <TableRow>[
                        TableRow(children: <Widget>[
                          Container(
                            height: 30,
                            child: Center(
                              child: Text("In",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black)),
                            ),
                          ),
                          Container(
                            height: 30,
                            child: Center(
                              child: Text("Out",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black)),
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
                            return SizedBox(
                              width: 300,child:
                             Table(
                              border: TableBorder.all(color: Colors.black),
                              children: <TableRow>[
                                TableRow(
                                  children: <Widget>[
                                    Container(
                                      height: 30,
                                      child: Center(
                                        child: Text(timeLog[position].inTime,
                                        textAlign: TextAlign.center,style:
                                        TextStyle(fontSize: 20, color: Colors.black)) 
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      child: Center(
                                        child: Text(timeLog[position].outTime,
                                                textAlign: TextAlign.center,style:
                                                TextStyle(fontSize: 20, color: Colors.black)), 
                                      ),
                                    )
                                                                        
                                  ],
                                ),
                              ],
                            ));
                          },
                          itemCount: timeLog.length,
                        ) 
              
                ),
              
            ],
          ),
        )
        
        );
      },
    );
  }
}
