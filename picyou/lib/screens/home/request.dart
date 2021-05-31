import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';
import 'package:picyou/services/database.dart';
import 'package:picyou/model/booking.dart';
import 'package:intl/intl.dart';

class Request extends StatefulWidget {
  final Booking booking;
  Request({this.booking});

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> with SingleTickerProviderStateMixin {
  String contact = ' ';
  String dp = ' ';
  String cover = ' ';
  final DatabaseService _db = DatabaseService();
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dynamic fetch = await _db.fetchClientData(widget.booking.clientId);
      setState(() {
        contact = fetch.contact;
        dp = fetch.display;
        cover = fetch.cover;
      });
    });
  }

  @override
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
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
                      child: Column(
                        children: [
                          Text(
                            'You have accepted the clients request!!',
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'We will notify the client for further details',
                            style: GoogleFonts.lato(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FlatButton(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            color: Color.fromRGBO(237, 237, 237, 1.0),
                            onPressed: () async {},
                            child: Text(
                              'Proceed',
                              style: TextStyle(
                                color: Color.fromRGBO(31, 31, 31, 1.0),
                                fontSize: 20,
                              ),
                            ),
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
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                            size: 50,
                          ),
                        )),
                  ),
                ]));
      },
    );
  }

  Future<void> _rejectDialog() async {
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
                    height: 370,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
                      child: Column(
                        children: [
                          Text(
                            "That's sad to hear!",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            'Tell us more about your experience.',
                            style: GoogleFonts.lato(fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0))),
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
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
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
                                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
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
                                    color: Colors.white,
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
                            FontAwesomeIcons.sadTear,
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
    DateTime date = widget.booking.date.toDate();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(date);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
            size: 32,
          ),
        ),
        title: Text(
          " Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          overflow: Overflow.visible,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(cover),
                    )),
                  ),
                )
              ],
            ),
            Container(
              height: 1000,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double innerWidth = constraints.maxWidth;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: 180,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 130,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            height: 130.0,
                            width: 130.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(dp),
                                ),
                                border: Border.all(
                                    color: Colors.white, width: 6.0)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 120),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 230, 10),
                                    child: Text(
                                      'Fullname:',
                                      style: GoogleFonts.lato(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(
                                              216, 181, 58, 1.0)),
                                    ),
                                  ),
                                  Container(
                                    width: 350,
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black38,
                                        width: 0.9,
                                      ),
                                    ),
                                    child: Text(
                                      widget.booking.clientName,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18.0,
                                          color:
                                              Color.fromRGBO(31, 31, 31, 1.0)),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 230, 10),
                                    child: Text(
                                      'Email:',
                                      style: GoogleFonts.lato(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(
                                              216, 181, 58, 1.0)),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    width: 350,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black38,
                                        width: 0.9,
                                      ),
                                    ),
                                    child: Text(
                                      widget.booking.clientEmail,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18.0,
                                          color:
                                              Color.fromRGBO(31, 31, 31, 1.0)),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 230, 10),
                                    child: Text(
                                      'Contact:',
                                      style: GoogleFonts.lato(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(
                                              216, 181, 58, 1.0)),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    width: 350,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black38,
                                        width: 0.9,
                                      ),
                                    ),
                                    child: Text(
                                      contact,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18.0,
                                          color:
                                              Color.fromRGBO(31, 31, 31, 1.0)),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 230, 10),
                                    child: Text(
                                      'Date:',
                                      style: GoogleFonts.lato(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(
                                              216, 181, 58, 1.0)),
                                    ),
                                  ),
                                  Container(
                                    width: 350,
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black38,
                                        width: 0.9,
                                      ),
                                    ),
                                    child: Text(
                                      "$formatted",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18.0,
                                          color:
                                              Color.fromRGBO(31, 31, 31, 1.0)),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 230, 10),
                                    child: Text(
                                      'Request:',
                                      style: GoogleFonts.lato(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(
                                              216, 181, 58, 1.0)),
                                    ),
                                  ),
                                  Container(
                                    width: 350,
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black38,
                                        width: 0.9,
                                      ),
                                    ),
                                    child: Text(
                                      widget.booking.request,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18.0,
                                          color:
                                              Color.fromRGBO(31, 31, 31, 1.0)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  FlatButton(
                                    padding:
                                        EdgeInsets.fromLTRB(30, 10, 30, 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    color: Color.fromRGBO(237, 237, 237, 1.0),
                                    onPressed: () {
                                      _rejectDialog();
                                    },
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(
                                        color: Color.fromRGBO(31, 31, 31, 1.0),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    padding:
                                        EdgeInsets.fromLTRB(35, 10, 35, 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    color: Color.fromRGBO(31, 31, 31, 1.0),
                                    onPressed: () {
                                      _showMyDialog();
                                    },
                                    child: Text(
                                      'Accept',
                                      style: TextStyle(
                                        color: Colors.white,
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
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
