import 'package:flutter/material.dart';
import 'package:picyou/model/review.dart';
import 'package:picyou/services/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewTile extends StatefulWidget {
  final Reviews reviews;

  ReviewTile({this.reviews});

  @override
  _ReviewTileState createState() => _ReviewTileState();
}

class _ReviewTileState extends State<ReviewTile> {
  String picture = ' ';
  String name = ' ';
  String email = ' ';
  double rating;
  final DatabaseService _db = DatabaseService();
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dynamic fetch = await _db.fetchClientData(widget.reviews.clientId);
      setState(() {
        picture = fetch.display;
        name = fetch.name;
        email = fetch.email;
        rating = widget.reviews.rating;
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
                      backgroundImage: NetworkImage(picture),
                    ),
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
                        width: 240,
                        child: Text(widget.reviews.review,
                            style: GoogleFonts.montserrat(fontSize: 12.0)),
                      ),
                      SizedBox(height: 7),
                      Container(
                        child: RatingBarIndicator(
                          rating: widget.reviews.rating,
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
