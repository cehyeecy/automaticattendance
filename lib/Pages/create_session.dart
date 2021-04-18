import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SessionCreate extends StatefulWidget {
  final FirebaseUser userLog;
  const SessionCreate({Key key, this.userLog}) : super(key: key);

  @override
  _SessionCreateState createState() => _SessionCreateState();
}

String uniqueCodeGenerator() {
  String uniqueCode = "";
  var rng = new Random();
  for (int i = 0; i < 5; i++) {
    bool numberOrchar = rng.nextBool();
    if (numberOrchar) {
      //capital alphabet in ASCII started from 65 to 91
      int charaterCode = 65 + rng.nextInt(26);
      uniqueCode = uniqueCode + String.fromCharCode(charaterCode);
    } else {
      //number in ASCII started from 48 to 57
      int characterCode = 48 + rng.nextInt(9);
      uniqueCode = uniqueCode + String.fromCharCode(characterCode);
    }
  }
  return uniqueCode;
}

class _SessionCreateState extends State<SessionCreate> {
  final DocumentReference documentReference =
      Firestore.instance.document("/Session");
  final formKey = new GlobalKey<FormState>();

  String _sessionname;

  Future<void> saveAndcreateSession() async {
    final form = formKey.currentState;
    try {
      if (form.validate()) {
        form.save();
        String uniqCode = uniqueCodeGenerator();
        Map<String, dynamic> dataMap = new Map<String, dynamic>();
        dataMap['session_name'] = _sessionname;
        dataMap['unique_code'] = uniqCode;
        dataMap['session_master'] = widget.userLog.uid;
        await Firestore.instance.collection("Session").add(dataMap).whenComplete(() {
          Navigator.pop(context);
        }).catchError((e) => print(e));
      }
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Session"),
      ),
      body: new Container(
        child: new Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Session Name'),
                  validator: (value) =>
                      value.isEmpty ? 'Session Name cannot be empty' : null,
                  onSaved: (value) => _sessionname = value,
                ),
                new RaisedButton(
                  child: new Text(
                    'Create Session',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: saveAndcreateSession,
                )
              ],
            )),
      ),
    );
  }
}
