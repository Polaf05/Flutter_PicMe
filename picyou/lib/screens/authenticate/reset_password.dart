import 'package:flutter/material.dart';
import 'package:picyou/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';


class ResetPassword extends StatefulWidget {
  final Function toggleReset;

  ResetPassword({this.toggleReset});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //text field state
  String email = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Container(
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
                        )
                ),
               SizedBox(height: 40),
                Container(
                  child: Form(
                    key: _formkey,
                    child: Column(children: <Widget>[
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
                    SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                               FlatButton(
                                    padding:
                                        EdgeInsets.fromLTRB(35, 10, 35, 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    color: Color.fromRGBO(216, 181, 58, 1.0),
                            onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                await _auth.forgotPassword(email);
                                widget.toggleReset();
                                }
                              },
                             child: Text(
                                      'SEND RESET PASSWORD',
                                      style: GoogleFonts.poppins(
                                        color: Color.fromRGBO(31, 31, 31, 1.0),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
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
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Already Have an Account?'),
                    FlatButton(
                      textColor: Color.fromRGBO(216, 181, 58, 1.0),
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(fontSize: 15, fontFamily: 'Arial'),
                      ),
                      onPressed: () {
                        widget.toggleReset();
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
              ],
            )));
  }
}
                           