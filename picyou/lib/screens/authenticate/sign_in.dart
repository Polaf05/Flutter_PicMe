import 'package:flutter/material.dart';
import 'package:picyou/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';


class SignIn extends StatefulWidget {
  final Function toggle;
  final Function toggleReset;
  SignIn({this.toggle, this.toggleReset});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //textfield states
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                          'PICYOU',
                          style: GoogleFonts.montserrat(
                            color: Color.fromRGBO(216, 181, 58, 1.0),
                            letterSpacing: 6.0,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 30),
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter email' : null,
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
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: TextFormField(
                          obscureText: true,
                          validator: (val) =>
                              val.isEmpty ? 'Enter password' : null,
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
                              if (_formKey.currentState.validate()) {
                                dynamic result =
                                    await _auth.signIn(email, password);
                                if (result == null) {
                                  setState(() => error = 'Invalid Email');
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
                      SizedBox(height: 14.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
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
                        style: TextStyle(fontSize: 15, fontFamily: 'Arial'),
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
                  children: <Widget>[
                    Text('Forgot Password?'),
                    FlatButton(
                      textColor: Color.fromRGBO(216, 181, 58, 1.0),
                      child: Text(
                        'RESET PASSWORD',
                        style: TextStyle(fontSize: 15, fontFamily: 'Arial'),
                      ),
                      onPressed: () {
                        widget.toggleReset();
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
                SizedBox(height: 20),
              ],
            )));
  }
}
