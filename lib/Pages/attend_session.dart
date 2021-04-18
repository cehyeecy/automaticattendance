import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AttendSession extends StatefulWidget {
  final FirebaseUser userLog;
  const AttendSession({Key key, this.userLog}) : super(key: key);

  @override
  _AttendSessionState createState() => _AttendSessionState();

  
}

class _AttendSessionState extends State<AttendSession> {

  String _uniqueCode;
  String _sessioncode;
  String _emailattendance;

  final CollectionReference collectionReference = Firestore.instance.collection("/Session");

  final formKey = new GlobalKey<FormState>();
  Future<void>checkCodeAndAttend() async {
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      try{
        QuerySnapshot querySnapshot = await Firestore.instance.collection("/Session").where("unique_code", isEqualTo: _uniqueCode).getDocuments();
        if(querySnapshot.documents.isNotEmpty){
         var document = querySnapshot.documents.last;
         _sessioncode = document.documentID;
         _emailattendance = widget.userLog.email;
         Map<String,dynamic> dataMap = new Map<String,dynamic>();
         dataMap['session_code'] = _sessioncode;
         dataMap['email_attendance'] = _emailattendance;
         await Firestore.instance.collection("Attendance").add(dataMap).whenComplete((){
           Navigator.pop(context);
         });
        }
      }
      catch(e){
        e.print();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attend Session'),
      ),
      body: new Container(
        child: new Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,             
            children: <Widget>[
              new TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Unique Code',
                  labelStyle: TextStyle(fontSize: 25, color: Colors.black),
                  hintStyle: TextStyle(fontSize: 20, color: Colors.black)
                  ),
                  textCapitalization: TextCapitalization.characters,
                  textAlign: TextAlign.center,
                  maxLength: 5,
                validator: (value) => value.isEmpty ? 'Fill the unique code' : null,
                onSaved: (value) => _uniqueCode = value,
              ),
              new RaisedButton(
                onPressed: checkCodeAndAttend,
                child: new Text('Attend With Unique Code',style: TextStyle(fontSize: 30, color: Colors.black),),
              )

            ],
            ),
          ),
      )
    );
  }
}