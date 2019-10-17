import 'package:flutter/material.dart';
import 'services.dart';

class Attendence extends StatefulWidget {
  final String value;
  Attendence({Key key, this.value}) : super(key: key);

  @override
  _AttendenceState createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendence'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Center(
          child: Column(
          children: <Widget>[
            FlatButton(
                color: Colors.blue,
                onPressed: () {
                  _fillAttendence(widget.value);
                },
                child: Text("Fill Attenedence")
                ),
                Table(                
                  border: TableBorder.all(color: Colors.black),
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        FittedBox(
                          child: Center(
                            child: Text("Date",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 1,
                              )
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Center(
                            child: Text("Day",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 1,
                              )
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Center(
                            child: Text("Hours \n in \n office",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 1,
                              )
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Center(
                            child: Text("Action",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 1,
                              )
                            ),
                          ),
                        ),
                      ]
                    ),
                    TableRow(
                      children: <Widget>[
                        FittedBox(
                          child: Center(
                            child: Text("17-10-2019",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 1,
                              )
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Center(
                            child: Text("Thursday",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 1,
                              )
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Center(
                            child: Text("5:00",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 1,
                              )
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Center(
                            child: Text("View",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 1,
                              )
                            ),
                          ),
                        ),
                      ] 
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fillAttendence(String userId) async {
    print("in first===========>");
    var response = await fillAttendence(userId);
    if (response != null) {
      print("in if ====> "+response);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Something went wrong"),
          );
        },
      );
    }
  }
}
