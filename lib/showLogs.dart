import 'package:flutter/material.dart';
import 'classes/attendence.dart';
import 'services.dart';


class ShowLogs extends StatefulWidget {
  final String value;
  ShowLogs({Key key, this.value}) : super(key: key);
  @override
  _ShowLogsState createState() => _ShowLogsState();  
}


class _ShowLogsState extends State<ShowLogs> {
  List<String> inTime, outTime = List<String>();
  @override
  Widget build(BuildContext context) {  
    return Scaffold(appBar: AppBar(title: Text("Show logs")),
    body:
    Container(
      child: Center(
        child: 
        FutureBuilder<Attendence>(
          future: _fillAttendence(widget.value),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(!snapshot.hasData){
              return Text("loading...");
              //  return SizedBox(
              //           child: Center(child: CircularProgressIndicator()),
              //           height: 20,
              //           width: 20);
            }else{
              print("snapshot++++++++++"+snapshot.data.timeLog[0].inTime+snapshot.data.timeLog[0].outTime);
              return ListView.builder(
                itemBuilder: (context, position){
                  return Table(
                    children: <TableRow>[
                      TableRow(children: <Widget>[
                        Text("Date"),
                        Text("Day"),
                        Text("Hours"),
                        ],
                      ),
                      TableRow(children: <Widget>[
                        Text(snapshot.data.date),
                        Text(snapshot.data.day),
                        Text("hello")
                      ])
                    ],
                  );
                },
                itemCount: snapshot.data.timeLog.length,
              );
            }
          },
        )
       
      ), 
    ));
  }

  Future<Attendence> _fillAttendence(String userId) async {
    var response = await fillAttendence(userId);
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
}

