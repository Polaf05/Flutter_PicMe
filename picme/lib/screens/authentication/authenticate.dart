import 'package:flutter/material.dart';
import 'package:picme/screens/authentication/register.dart';
import 'package:picme/screens/authentication/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Signin(toggle: toggleView);
    } else {
      return Register(toggle: toggleView);
    }
  }
}
