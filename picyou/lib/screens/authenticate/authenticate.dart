import 'package:flutter/material.dart';
import 'package:picyou/screens/authenticate/reset_password.dart';
import 'package:picyou/screens/authenticate/sign_in.dart';
import 'package:picyou/screens/authenticate/sign_up.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignup = false;
  bool showReset = false;
  void toggleView() {
    setState(() {
      showSignup = !showSignup;
    });
  }

  void toggleReset() {
    setState(() {
      showReset = !showReset;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!showSignup) {
      if (!showReset) {
        return SignIn(toggle: toggleView, toggleReset: toggleReset);
      } else {
        return ResetPassword(toggleReset: toggleReset);
      }
    } else {
      return SignUp(toggle: toggleView);
    }
  }
}
