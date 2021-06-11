import 'package:flutter/material.dart';
import 'package:picyou/screens/home/gallery/galdisp.dart';
import 'package:picyou/screens/home/request/request_display.dart';
import 'package:picyou/screens/home/review/review_display.dart';
import 'package:picyou/services/auth.dart';
import 'package:picyou/screens/home/edit.dart';
import 'package:picyou/services/database.dart';
import 'package:provider/provider.dart';
import 'package:picyou/model/lensmen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_switch_button/custom_switch_button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  TabController _controller;
  bool isChecked = false;


  String username = ' ';
  String name = ' ';
  String address = ' ';
  String contact = ' ';
  String email = ' ';
  dynamic gallery = ' ';
  String displayPicture = ' ';
  String coverPhoto = ' ';
  String def_pic =
      "https://firebasestorage.googleapis.com/v0/b/picme-4c5ea.appspot.com/o/Assets%2Fdefault%20dp%2F360_F_410437733_hdq4Q3QOH9uwh0mcqAhRFzOKfrCR24Ta.jpg?alt=media&token=b1ae5147-b094-4e53-b7ac-518a6f4c218c";
  String def_cover =
      "https://firebasestorage.googleapis.com/v0/b/picme-4c5ea.appspot.com/o/Assets%2Fdefault%20cover%2Fdefault_cover.jpg?alt=media&token=9e6c8eb3-e5b0-4cfc-a24a-3e4619c885b3";
  @override
  void initState() {
    _controller = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dynamic id = _auth.getCurrentUser();
      dynamic fetch = await _db.fetchUserData(id.uid);
      setState(() {
        username = fetch.username;
        name = fetch.name;
        address = fetch.address;
        contact = fetch.contact;
        email = fetch.email;
        gallery = fetch.gallery;
        displayPicture = fetch.displayPicture;
        coverPhoto = fetch.coverPhoto;
      });

      print(displayPicture);
      print(coverPhoto);
    });
  }

  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return StreamProvider<List<Lensmen>>.value(
      value: DatabaseService().lensmen,
      initialData: List(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                FontAwesomeIcons.userCircle,
                color: Color.fromRGBO(216, 181, 58, 1.0),
              ),
              label: Text(
                'Logout',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                ),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
          title: Text(
            "Profile",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          centerTitle: false,
        ),
        body: ListView(children: <Widget>[
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
                            image: NetworkImage(coverPhoto),
                          )),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 130.0,
                    left: 20.0,
                    child: Container(
                      height: 160.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(displayPicture),
                          ),
                          border: Border.all(color: Colors.white, width: 6.0)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 25),
                        alignment: Alignment.topLeft,
                        child: Text(
                          username,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 170,
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: Text("Edit Profile",
                                style: TextStyle(fontSize: 18.0)),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.fromLTRB(40, 15, 40, 15)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                shape:
                                    MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: BorderSide(
                                                color: Color.fromRGBO(
                                                    216, 181, 58, 1.0))))),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Edit()));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25),
                    alignment: Alignment.topLeft,
                    child: Text(
                      email,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.link,
                          size: 20, color: Color.fromRGBO(216, 181, 58, 1.0)),
                      SizedBox(width: 10),
                      Text(
                        name,
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
                      GestureDetector(
                              onTap: () {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                                child: CustomSwitchButton(
                                  backgroundColor: Color.fromRGBO(216, 181, 58, 1.0),
                                  unCheckedColor: Colors.white,
                                  animationDuration: Duration(milliseconds: 400),
                                  checkedColor: Colors.black,
                                  checked: isChecked,
                                ),
                              ),
                          SizedBox(width: 10),
                              Text(
                                'Is it urgent?',
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
                  Container(
                    decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor),
                    child: new TabBar(
                      controller: _controller,
                      unselectedLabelColor: Color.fromRGBO(237, 237, 237, 1.0),
                      indicator: BoxDecoration(
                          color: Color.fromRGBO(43, 43, 43, 1.0),
                          border: Border(
                            top: BorderSide(
                                width: 4.0,
                                color: Color.fromRGBO(216, 181, 58, 1.0)),
                          )),
                      labelColor: Color.fromRGBO(216, 181, 58, 1.0),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Gallery",
                                style: TextStyle(
                                    fontFamily: "BarlowBold", fontSize: 15.0)),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("View Request",
                                style: TextStyle(
                                    fontFamily: "BarlowBold", fontSize: 15.0)),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Reviews",
                                style: TextStyle(
                                    fontFamily: "BarlowBold", fontSize: 15.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 5,
                      bottom: 0,
                    ),
                    height: MediaQuery.of(context).size.height,
                    child: new TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        // GridView.builder(
                        //   gridDelegate:
                        //       SliverGridDelegateWithMaxCrossAxisExtent(
                        //           maxCrossAxisExtent: 150,
                        //           childAspectRatio: 1,
                        //           crossAxisSpacing: 10,
                        //           mainAxisSpacing: 10),
                        //   itemCount: gallery.length,
                        //   itemBuilder: (BuildContext ctx, index) {
                        //     return Container(
                        //       alignment: Alignment.center,
                        //       decoration: BoxDecoration(
                        //         color: Colors.amber,
                        //         borderRadius:
                        //             BorderRadius.circular(15),
                        //         image: DecorationImage(
                        //           image:
                        //               NetworkImage(gallery[index]),
                        //           fit: BoxFit.fill,
                        //         ),
                        //       ),
                        //     );
                        //   }
                        //   ),
                        GalleryDisp(),
                        RequestDisp(),
                        ReviewDisp(),
                      ],
                    ),
                  ),
                ]))
          ]),
        ]),
      ),
    );
  }
}
