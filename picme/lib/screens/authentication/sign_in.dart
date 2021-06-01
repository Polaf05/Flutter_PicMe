import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:picme/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:picme/services/database.dart';
import 'package:picme/shared/loading.dart';
import 'package:google_fonts/google_fonts.dart';

class Signin extends StatefulWidget {
  //Accept class arguments
  final Function toggle;
  final Function toggleReset;
  Signin({this.toggle, this.toggleReset});

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Stack(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(15, 80, 15, 0),
                    child: ListView(
                      children: <Widget>[
                        Center(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/kiven.png',
                            width: 100,
                            height: 100,
                          ),
                        )),
                        Center(
                            child: Text(
                          'PICME',
                          style: GoogleFonts.montserrat(
                            color: Color.fromRGBO(216, 181, 58, 1.0),
                            letterSpacing: 6.0,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
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
                        SizedBox(height: 15),
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
                        SizedBox(height: 20),
                        Container(
                          child: Form(
                            key: _formkey,
                            child: Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
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
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: TextFormField(
                                  validator: (val) => val.length < 4
                                      ? 'Password must be 5 or more Character'
                                      : null,
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
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlatButton(
                                    padding:
                                        EdgeInsets.fromLTRB(135, 10, 135, 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    color: Color.fromRGBO(216, 181, 58, 1.0),
                                    onPressed: () async {
                                      if (_formkey.currentState.validate()) {
                                        setState(() => loading = true);
                                        bool result = await DatabaseService()
                                            .checkUser(email, password);
                                        if (!result) {
                                          setState(() {
                                            error =
                                                'Email and Password did not match';
                                            loading = false;
                                          });
                                        } else {
                                          dynamic status = await _auth
                                              .signInWithEmailAndPassword(
                                                  email, password);
                                          if (status == null) {
                                            setState(() {
                                              error =
                                                  'Email and Password did not match';
                                              loading = false;
                                            });
                                          }
                                        }
                                      }
                                    },
                                    child: Text(
                                      'LOGIN',
                                      style: GoogleFonts.poppins(
                                        color: Color.fromRGBO(31, 31, 31, 1.0),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.0),
                              Center(
                                child: Text(
                                  error,
                                  style: TextStyle(
                                      color: Color.fromRGBO(216, 181, 58, 1.0),
                                      fontSize: 14.0),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Container(
                            child: Row(
                          children: <Widget>[
                            Text('Does not have account?'),
                            FlatButton(
                              textColor: Color.fromRGBO(216, 181, 58, 1.0),
                              child: Text(
                                'SIGN UP',
                                style: GoogleFonts.lato(fontSize: 15),
                              ),
                              onPressed: () {
                                widget.toggle();
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Forgot Password?'),
                            FlatButton(
                              textColor: Color.fromRGBO(216, 181, 58, 1.0),
                              child: Text(
                                'RESET PASSWORD',
                                style: GoogleFonts.lato(fontSize: 15),
                              ),
                              onPressed: () {
                                widget.toggleReset();
                              },
                            )
                          ],
                        )),
                      ],
                    )),
              ],
            ),
          );
  }
}
