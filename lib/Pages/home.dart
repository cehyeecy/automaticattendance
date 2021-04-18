import 'package:automatic_attendance/Pages/attend_session.dart';
import 'package:automatic_attendance/Pages/create_session.dart';
import 'package:automatic_attendance/Pages/session_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'create_session.dart';

class Home extends StatefulWidget {
  final FirebaseUser userLog;
  const Home({Key key, this.userLog}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("${widget.userLog.email}"),
        automaticallyImplyLeading: false,
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => new SessionCreate(userLog: widget.userLog,)));
              },
              child: const Text(
                'Create Session',
                style: TextStyle(fontSize: 20)
              ),
            ),
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => new AttendSession(userLog: widget.userLog,)));
              },
              child: const Text(
                'Attend A Session',
                style: TextStyle(fontSize: 20)
                )
            ),
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => new SessionList(userLog: widget.userLog,)));
              },
              child: const Text(
                'Session List',
                style: TextStyle(fontSize: 20)
                ),
              ),
          ],
        ),
      ),
    );
  }
}