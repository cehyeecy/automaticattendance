import 'package:automatic_attendance/Pages/home.dart';
import 'package:automatic_attendance/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
} //loginpage

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String _schemail;
  String _password;

  //login
  Future<void> validateAndSubmit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      try {
        //if succeed login and head to home page
        FirebaseUser userLog = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _schemail, password: _password);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(userLog: userLog = userLog)));
      } catch (err) {
        //case if something error happen
        print(err.message);
      }
    }
  }

  //body form and button
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Automatic Attendance Project'),
        ),
        body: new Container(
          padding: EdgeInsets.all(16),
          child: new Form(
            key: formKey,
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
                  child: new Text('Login',
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      )),
                  onPressed: validateAndSubmit,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(30, 144, 255, 1)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
} //_LoginPageState
