import 'package:flutter/material.dart';
import 'package:picyou/services/auth.dart';

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
                          TextButton(
                            child:
                                Text("LOGIN", style: TextStyle(fontSize: 20.0)),
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
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                dynamic result =
                                    await _auth.signIn(email, password);
                                if (result == null) {
                                  setState(() => error = 'Invalid Email');
                                }
                              }
                            },
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
                      textColor: Colors.green[400],
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
                      textColor: Colors.green[400],
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
