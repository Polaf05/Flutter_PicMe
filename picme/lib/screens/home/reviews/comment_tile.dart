import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/services/database.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:picme/models/booking.dart';

class CommentTile extends StatefulWidget {
  final Review reviews;

  CommentTile({this.reviews});

  @override
  _CommentTileState createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  AuthService _auth = AuthService();
  DatabaseService _db = DatabaseService();

  dynamic info;
  String name = '';
  String display = '';
  String email = '';

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dynamic fetch = await _db.fetchClientData(widget.reviews.clientId);
      setState(() {
        info = fetch;
        name = fetch.name;
        display = fetch.display;
        email = fetch.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom:
                BorderSide(color: Color.fromRGBO(216, 181, 58, 1.0), width: 1),
          )),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 75.5,
                    color: Colors.transparent,
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(display)),
                  ),
                  SizedBox(width: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          SizedBox(width: 5),
                          Container(
                            child: Text(
                              email,
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0,
                                  color: Colors.black38),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7),
                      Container(
                        width: 255,
                        child: Text(widget.reviews.comment,
                            style: GoogleFonts.montserrat(fontSize: 12.0)),
                      ),
                      SizedBox(height: 7),
                      Container(
                        child: RatingBarIndicator(
                          rating: widget.reviews.rating.toDouble(),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
