import 'package:flutter/material.dart';
import 'package:picme/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:picme/shared/loading.dart';
import 'package:google_fonts/google_fonts.dart';


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
  bool loading = false;

  //text field state
  String email = "";
  String name = "";
  String password = "";
  String confirm = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
                padding: EdgeInsets.fromLTRB(15, 50, 15, 0),
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Sign Up',
                        style:  GoogleFonts.lato(
                          color: Color.fromRGBO(26, 181, 158, 1.0),
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
                              obscureText: true,
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
                                            Color.fromRGBO(216, 181, 58, 1.0)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: BorderSide(
                                                color: Color.fromRGBO(216, 181, 58, 1.0))))),
                                onPressed: () async {
                                  if (_formkey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, password, name);
                                    if (result == null) {
                                      setState(() {
                                        error = AuthService.error;
                                        loading = false;
                                      });
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
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
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
                          textColor: Color.fromRGBO(216, 181, 58, 1.0),
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
                            style: GoogleFonts.lato(
                              color: Colors.black54,
                              fontSize: 15,
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
