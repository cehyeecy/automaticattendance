import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SessionDetails extends StatefulWidget {
  final DocumentSnapshot sessionDocuments;

  const SessionDetails({Key key, this.sessionDocuments}) : super(key: key);

  @override
  _SessionDetailsState createState() => _SessionDetailsState();
}

class _SessionDetailsState extends State<SessionDetails> {
  Widget _sessionDetailData(BuildContext context, DocumentSnapshot documents) {
    return ListTile(
        title: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                documents.data['email_attendance'],
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.sessionDocuments.documentID}');
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.sessionDocuments.data['unique_code']}::${widget.sessionDocuments.data['session_name']}"),
              
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection("/Attendance")
              .where("session_code",
                  isEqualTo: widget.sessionDocuments.documentID)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("Loading...");
            return ListView.builder(
              itemExtent: 80,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _sessionDetailData(context, snapshot.data.documents[index]),
            );
          }),
    );
  }
}
