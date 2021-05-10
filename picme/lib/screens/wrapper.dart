import 'package:flutter/material.dart';
import 'package:picme/models/user.dart';
import 'package:picme/screens/authentication/authenticate.dart';
import 'package:picme/screens/home/client.dart';
import 'package:picme/screens/home/home.dart';
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
