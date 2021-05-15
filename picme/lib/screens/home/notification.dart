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
import 'home.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NotificationTab extends StatefulWidget {
  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
          return Dialog(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              child: Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 500,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
                        child: Column(
                          children: [
                            Text(
                              'Rate our lensman',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              'Tap a star to give your rating.',
                              style: GoogleFonts.lato(
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                          child: RatingBarIndicator(
                            rating: 2.75,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 40.0,
                          ),
                        ),
                    Container(
                        child: Divider(
                          height: 30,
                          color: Color.fromRGBO(216, 181, 58, 1.0),
                        ),
                      ),
                         Container(
                           margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                           child: Text(
                                'Tell us more about your experience.',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Color.fromRGBO(216, 181, 58, 1.0)),
                                textAlign: TextAlign.center,
                              ),
                         ),
                         Container(
                                  margin: EdgeInsets.fromLTRB(10,0,10,20),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: 'Enter comment',
                                      labelText: 'Review',
                                    ),
                                  ),
                                ),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            FlatButton(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              color: Color.fromRGBO(237, 237, 237, 1.0),
                              onPressed: () async {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Color.fromRGBO(31, 31, 31, 1.0),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          FlatButton(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 10, 30, 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      color: Color.fromRGBO(31, 31, 31, 1.0),
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()),
                                          (Route<dynamic> route) => false,
                                        );
                                      },
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                          color:
                                             Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                        ],
                        ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -60,
                      child: GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
                            radius: 60,
                            child: Icon(
                              FontAwesomeIcons.commentAlt,
                              color: Colors.white,
                              size: 50,
                            ),
                          )),
                    ),
                  ]));
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 60, 90, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Lensman to Review',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 28.0),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 68),
            child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 55.5,
                                    height: 55.5,
                                    color: Colors.transparent,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: AssetImage(
                                        'assets/en.jpg',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Monkey D. Luffy',
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                      Text('luffy@example.com',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12.0)),
                                      Text('Done',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10.0,
                                              backgroundColor: Colors.grey[100],
                                              color: Colors.green)),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: FlatButton(
                                  onPressed: () {
                                    _showMyDialog();
                                  },
                                  color: Color.fromRGBO(216, 181, 58, 1.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0)),
                                  child: Text(
                                    'Rate',
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
