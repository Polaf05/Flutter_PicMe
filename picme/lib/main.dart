import 'package:flutter/material.dart';
import 'package:picme/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:picme/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:picme/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        home: Wrapper(),
      ),
    );
  }
}
