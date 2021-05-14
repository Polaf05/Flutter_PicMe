import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:picme/models/user.dart';
import 'package:picme/screens/home/book.dart';
import 'package:picme/models/lensman.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picme/screens/home/edit.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/services/database.dart';
import 'package:picme/screens/home/lensman_tile.dart';

class ClientProfile extends StatefulWidget {
  @override
  _ClientProfileState createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  AuthService _auth = AuthService();
  DatabaseService _db = DatabaseService();

  dynamic info;

  String name = "";
  String email = "";
  String address = "";
  String contact = "";
  String display = "";
  String cover = "";
  String bio = "";
  String id = "";

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dynamic id = _auth.getCurrentUser();
      dynamic fetch = await _db.fetchClientData(id.uid);
      setState(() {
        info = fetch;
        name = fetch.name;
        email = fetch.email;
        address = fetch.address;
        contact = fetch.contact;
        display = fetch.display;
        cover = fetch.cover;
        bio = fetch.bio;
        id = fetch.id;
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
                            image: NetworkImage(cover),
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
                            image: NetworkImage(display),
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
                    name,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 28.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
                child: Text(
              email,
              style: GoogleFonts.montserrat(fontSize: 18.0),
            )),
            SizedBox(
              height: 10.0,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 15, 20),
                child: Text(
                  bio,
                  style: GoogleFonts.montserrat(fontSize: 18.0),
                  textAlign: TextAlign.center,
                )),
            Container(
              child: Divider(
                height: 30,
                color: Color.fromRGBO(216, 181, 58, 1.0),
              ),
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
                      SizedBox(width: 10),
                      Text(
                        address,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
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
                      SizedBox(width: 10),
                      Text(
                        contact,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.link_outlined,
                          size: 20, color: Color.fromRGBO(216, 181, 58, 1.0)),
                      SizedBox(width: 10),
                      Text(
                        "Social Media Account",
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            child: Center(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                  ),
                ]))
          ])
        ]));
  }
}
