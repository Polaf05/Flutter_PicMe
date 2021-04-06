import 'package:flutter/material.dart';
import 'package:picme/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Register extends StatefulWidget {
  //Accept class arguments
  final Function toggle;
  Register({this.toggle});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //text field state
  String email = "";
  String name = "";
  String password = "";
  String confirm = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.fromLTRB(15, 50, 15, 0),
            child: ListView(
              children: <Widget>[
                Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: Colors.red[700],
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  child: Form(
                    key: _formkey,
                    child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 30),
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter a Name' : null,
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 30),
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 30),
                        child: TextFormField(
                          validator: (val) =>
                              val.length < 4 ? 'Enter an Password' : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: TextFormField(
                          validator: (val) => val != password
                              ? 'Password does not match'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => confirm = val);
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Confirm Password',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            child: Text("Sign Up",
                                style: TextStyle(fontSize: 20.0)),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.fromLTRB(80, 15, 80, 15)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red[400]),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Colors.red[400])))),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() =>
                                      error = 'Please supply a valid email');
                                }
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Center(
                        child: Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Already have an account?'),
                    FlatButton(
                      textColor: Colors.red[400],
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(fontSize: 15, fontFamily: 'Arial'),
                      ),
                      onPressed: () {
                        widget.toggle();
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(35, 10, 30, 0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '━━━━━━━ OR CONNECT WITH ━━━━━━━',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 15,
                          fontFamily: 'Arial',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton.icon(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      color: Colors.blue[800],
                      onPressed: () async {
                        await _auth.resultFacebookSignIn();
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Facebook',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    RaisedButton.icon(
                      padding: EdgeInsets.fromLTRB(15, 10, 20, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      color: Colors.red[600],
                      onPressed: () async {
                        await _auth.signInWithGoogle();
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Google',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}
