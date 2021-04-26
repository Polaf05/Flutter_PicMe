import 'package:flutter/material.dart';
import 'package:picme/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:picme/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

      Map<int, Color> color =
      {
      50:Color.fromRGBO(216,181,58, .1),
      100:Color.fromRGBO(216,181,58, .2),
      200:Color.fromRGBO(216,181,58, .3),
      300:Color.fromRGBO(216,181,58, .4),
      400:Color.fromRGBO(216,181,58, .5),
      500:Color.fromRGBO(216,181,58, .6),
      600:Color.fromRGBO(216,181,58, .7),
      700:Color.fromRGBO(216,181,58, .8),
      800:Color.fromRGBO(216,181,58, .9),
      900:Color.fromRGBO(216,181,58, 1),
      };

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MaterialColor colorCustom = MaterialColor(0xFFd8b53a, color);
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: colorCustom,
         
          ),
        home: Wrapper(),
      ),
    );
  }
}
