import 'package:flutter/material.dart';
import 'package:picyou/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';


class SignUp extends StatefulWidget {
  final Function toggle;

  SignUp({this.toggle});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //textfield
  String username = "";
  String name = "";
  String address = "";
  String contact = "";
  String email = "";
  String password = "";
  String confirm = "";
  String error = "";
  List<String> gallery = null;
  String displayPicture =
      "https://firebasestorage.googleapis.com/v0/b/picme-4c5ea.appspot.com/o/Lensman%2Ftest1%2F160279455_3725976577479855_6794694972857135677_n.jpg?alt=media&token=36e1a30c-62d7-42ec-917c-0d1a304b8d57";
  String role = 'lensmen';
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
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter name' : null,
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
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: TextFormField(
                          validator: (val) => val.isEmpty
                              ? 'Enter username or company name'
                              : null,
                          onChanged: (val) {
                            setState(() => username = val);
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Company Name or Username',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter address' : null,
                          onChanged: (val) {
                            setState(() => address = val);
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Address',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter contact' : null,
                          onChanged: (val) {
                            setState(() => contact = val);
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Contact',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
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
                          validator: (val) =>
                              val.length < 6 ? 'Enter 6+ characters' : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          obscureText: true,
                          //onchange
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
                          onChanged: (val) {
                            setState(() => confirm = val);
                          },
                          obscureText: true,
                          //onchange
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
                          FlatButton(
                                    padding:
                                        EdgeInsets.fromLTRB(130, 10, 130, 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    color: Color.fromRGBO(216, 181, 58, 1.0),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                dynamic result = await _auth.register(
                                  username,
                                  name,
                                  address,
                                  contact,
                                  email,
                                  password,
                                  gallery,
                                  displayPicture,
                                  role,
                                );
                                if (result == null) {
                                  setState(() => error = 'supply vald email');
                                }
                              }
                            },
                             child: Text(
                                      'REGISTER',
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
                        //widget.toggleReset();
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
