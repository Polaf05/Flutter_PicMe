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
import 'package:picme/services/email.dart';
import 'home.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:picme/models/booking.dart';

class RatingTile extends StatefulWidget {
  final Booking booking;

  RatingTile({this.booking});

  @override
  _RatingTileState createState() => _RatingTileState();
}

class _RatingTileState extends State<RatingTile> {
  DatabaseService _db = DatabaseService();
  MailerService _mail = MailerService();

  int ratingNumber = 0;
  String comment = "";
  int finalRating = 0;
  String name = '';
  String display = '';

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dynamic result = await _db.fetchUserData(widget.booking.lensmanId);
      setState(() {
        name = result.name;
        finalRating = result.rating;
        display = result.display;
      });
      print(result.rating);
    });
  }

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
                            style: GoogleFonts.lato(fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  ratingNumber = rating.toInt();
                                });
                              },
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
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  comment = val;
                                });
                              },
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
                                onPressed: () {
                                  Navigator.pop(context);
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
                                onPressed: () async {
                                  await _db.rateLensman(
                                      widget.booking.clientId,
                                      widget.booking.lensmanId,
                                      comment,
                                      ratingNumber,
                                      widget.booking.id);
                                  await _db.updateFinalRating(
                                      widget.booking.lensmanId,
                                      finalRating,
                                      ratingNumber);

                                  await _mail.sendReview(
                                      widget.booking.clientEmail,
                                      widget.booking.clientName,
                                      widget.booking.lensmanEmail,
                                      widget.booking.lensmanName,
                                      widget.booking.id,
                                      widget.booking.request);

                                  Navigator.pop(context);
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
    Color getColor(String status) {
      if (status == 'Rejected') return Colors.red;
      if (status == 'Pending') return Colors.red;
      if (status == 'Accepted') return Colors.green;
      if (status == 'For Review') return Colors.red;
      if (status == 'Done') return Colors.green;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 55.5,
                    height: 55.5,
                    color: Colors.transparent,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(display),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.booking.lensmanName,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      Text(widget.booking.lensmanEmail,
                          style: GoogleFonts.montserrat(fontSize: 12.0)),
                      Text(widget.booking.status,
                          style: GoogleFonts.montserrat(
                              fontSize: 10.0,
                              backgroundColor: Colors.grey[100],
                              color: getColor(widget.booking.status))),
                    ],
                  )
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: FlatButton(
                  disabledColor: Colors.grey,
                  onPressed: widget.booking.status == "For Review"
                      ? () => _showMyDialog()
                      : null,
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
    );
  }
}
