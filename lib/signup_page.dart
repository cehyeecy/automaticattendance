import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formSignUp = new GlobalKey<FormState>();

  String _schemail;
  String _password;

  Future<void> validateAndRegister() async {
    final form = formSignUp.currentState;
    if (form.validate()) {
      form.save();
      try {
        //if succeed register into firebase
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _schemail, password: _password);
        Navigator.pop(context);
      } catch (err) {
        //case if something error happen
        print(err.message);
      }
    }
  }

  //body
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Automatic Attendance Project'),
        ),
        body: new Container(
          padding: EdgeInsets.all(16),
          child: new Form(
            key: formSignUp,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Email'),
                  validator: (value) =>
                      value.isEmpty ? 'Email can not be empty' : null,
                  onSaved: (value) => _schemail = value,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) =>
                      value.isEmpty ? 'Password can not be empty' : null,
                  onSaved: (value) => _password = value,
                ),
                new RaisedButton(
                  child: new Text('Register',
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      )),
                  onPressed: validateAndRegister,
                ),
              ],
            ),
          ),
        ));
  }
}
