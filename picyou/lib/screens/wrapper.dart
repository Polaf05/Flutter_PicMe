import 'package:flutter/material.dart';
import 'package:picyou/model/user.dart';
import 'package:picyou/screens/authenticate/authenticate.dart';
import 'package:picyou/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserCreds>(context);

    //listener
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
