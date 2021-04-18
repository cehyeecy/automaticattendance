import 'package:automatic_attendance/Pages/session_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SessionList extends StatefulWidget {

  final FirebaseUser userLog;

  const SessionList({Key key, this.userLog}) : super(key: key);

  @override
  _SessionListState createState() => _SessionListState();
}

class _SessionListState extends State<SessionList> {

  Widget _sessionListData(BuildContext context, DocumentSnapshot documents){
    return ListTile(
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 300),
              child: OutlineButton(
                child: Text(
                  documents.data['session_name'],
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => new SessionDetails(sessionDocuments: documents,)));
                },
                borderSide: BorderSide(
                  color: Colors.cyan,
                  style: BorderStyle.solid
                  ),
              ), 
            ),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Session List"),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection("/Session").where('session_master', isEqualTo: widget.userLog.uid).snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData) return Text('Loading...');
            return ListView.builder(
              itemExtent: 80,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index) => _sessionListData(context, snapshot.data.documents[index])
            );
          },
        ),
    );
  }
}