import 'package:flutter/material.dart';
import 'package:picyou/services/auth.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.fromLTRB(15, 80, 15, 0),
            child: ListView(
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/new.png'),
                    radius: 60.0,
                  ),
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: TextFormField(
                          // validator: (val) =>
                          //     val.isEmpty ? 'Enter username or company name' : null,
                          // onChanged: (val) {
                          //   setState(() => name = val);
                          // },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Company Name or Username',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Address',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Contact',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: TextFormField(
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
                          TextButton(
                            child: Text("REGISTER",
                                style: TextStyle(fontSize: 20.0)),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.fromLTRB(80, 15, 80, 15)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green[400]),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Colors.green[400])))),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {}
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      Center(
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.green, fontSize: 14.0),
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
                      textColor: Colors.green[400],
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
                      textColor: Colors.green[400],
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
