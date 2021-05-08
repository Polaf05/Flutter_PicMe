import 'package:flutter/material.dart';
import 'package:picme/models/user.dart';
import 'package:picme/screens/home/book.dart';
import 'package:picme/models/lensman.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picme/screens/home/edit.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/services/database.dart';

class ClientProfile extends StatefulWidget {
  @override
  _ClientProfileState createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  AuthService _auth = AuthService();
  DatabaseService _db = DatabaseService();

  dynamic info;
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dynamic id = _auth.getCurrentUser();
      dynamic fetch = await _db.fetchClientData(id.uid);
      setState(() {
        info = fetch;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: null,
        body: new ListView(children: <Widget>[
          new Column(children: <Widget>[
            Container(
              child: Stack(
                alignment: Alignment.bottomCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/1.jpg'),
                          )),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 100.0,
                    child: Container(
                      height: 190.0,
                      width: 190.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/11.jpg'),
                          ),
                          border: Border.all(color: Colors.white, width: 6.0)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Monkey D. Luffy',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
                child: Text(
              'luffy@example.com',
              style: TextStyle(fontSize: 18.0),
            )),
            SizedBox(
              height: 20.0,
            ),
            Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_pin,
                          size: 20, color: Color.fromRGBO(216, 181, 58, 1.0)),
                      Text(
                        "Gagalangin Tondo, Manila",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.call,
                          size: 20, color: Color.fromRGBO(216, 181, 58, 1.0)),
                      Text(
                        "09213232076",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.link_off_outlined,
                          size: 30, color: Color.fromRGBO(216, 181, 58, 1.0)),
                      Text(
                        "Social Media Account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Row(
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.fromLTRB(125, 10, 125, 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: Color.fromRGBO(216, 181, 58, 1.0),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Edit(user: info)),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text(
                            'Edit Profile',
                            style: GoogleFonts.poppins(
                              color: Color.fromRGBO(31, 31, 31, 1.0),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10.0,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                ]))
          ])
        ]));
  }
}
