import 'package:flutter/material.dart';
import 'package:picme/screens/authentication/register.dart';
import 'package:picme/screens/authentication/sign_in.dart';
import 'package:picme/screens/authentication/reset_password.dart';

class Authenticate extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Authenticate> {
  bool showSignIn = true;
  bool showForgot = false;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  void toggleReset() {
    setState(() => showForgot = !showForgot);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      if (showForgot) {
        return ResetPassword(toggleReset: toggleReset);
      } else {
        return Signin(toggle: toggleView, toggleReset: toggleReset);
      }
    } else {
      return Register(toggle: toggleView);
    }
  }
}
