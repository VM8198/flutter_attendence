import 'package:flutter/material.dart';
import 'services.dart';
import 'dart:convert';
import 'classes/attendence.dart';

class SecondScreen extends StatefulWidget {
  final String value;
  SecondScreen({Key key, this.value}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Attendence'),
        ),
        body:
          FutureBuilder<Attendence>(
          future: _fillAttendence(widget.value),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return Text(snapshot.hasData.toString());
            print("snapshot++++++++++++++++++" + snapshot.data.id);
            var data = snapshot.data;
            
            ListTile _buildItemsForListView(BuildContext context, int index) {
              if (index < data.timeLog.length) {
                return ListTile(
                  title: Row(children: <Widget>[
                    Expanded(child: Text(data.timeLog[index].inTime)),
                    Expanded(child: Text(data.timeLog[index].outTime)),
                  ]),
                );
              }
            }

            return ListView.builder(
              itemBuilder: _buildItemsForListView,
            );
          },
        ));

       
      
      
  }

  Future<Attendence> _fillAttendence(String userId) async {
    print("in first=================>");
    var response = await fillAttendence(userId);
    if (response != null) {
      print("returning here also..." + response.toString());
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






