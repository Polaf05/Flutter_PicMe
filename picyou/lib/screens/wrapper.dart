import 'package:flutter/material.dart';
import 'package:picyou/screens/authenticate/authenticate.dart';
import 'package:picyou/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either home or authenticate
    return Authenticate();
  }
}
