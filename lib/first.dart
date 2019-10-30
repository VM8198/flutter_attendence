import 'package:attendence/showLogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'services.dart';
import 'classes/attendence.dart';
import 'drawer.dart';
import 'style/loader.dart';


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
        drawer: MyDrawer(),
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
                      child: isClicked ? Text("Fill Attendence") : Text("Remove"),
                  ),                  
                ]),
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
                    future: _getMultipleDaysLogs(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData)
                        return SizedBox(
                            child: Center(child: ColorLoader3()),
                            height: 20,
                            width: 20);
                      if (snapshot.hasData) {
                        var data = snapshot.data;
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
        ),
      );
  }

  Future<Attendence> _fillAttendence() async {
    var response = await fillAttendence();
    print("FILL ATTENDENCE");
    if (response != null) {
      setState(() {
       isClicked = !isClicked; 
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

  Future<MultipleDaysLogs> _getMultipleDaysLogs() async{
    print("==================================");
    var response = await getMultipleDaysLogs();
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

  handleChangePage(uid){
    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShowLogs(value: uid)),
        );
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
                flex: 1,
                  child: ListView.builder(
                        itemBuilder: (context, position) {
                            return Table(
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
                            );
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
