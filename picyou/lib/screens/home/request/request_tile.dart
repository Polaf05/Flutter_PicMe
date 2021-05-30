import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:picyou/model/booking.dart';
import 'package:picyou/services/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:picyou/screens/home/request.dart';

class RequestTile extends StatefulWidget {
  final Booking booking;

  RequestTile({this.booking});

  @override
  _RequestTileState createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  String picture = ' ';
  final DatabaseService _db = DatabaseService();
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dynamic fetch = await _db.fetchClientData(widget.booking.clientId);
      setState(() {
        picture = fetch.display;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 2,
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
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          widget.booking.clientName,
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                      Text(widget.booking.clientEmail,
                          style: GoogleFonts.montserrat(fontSize: 14.0)),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.arrowCircleRight),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Request()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   child: Card(
    //     child: ListTile(
    //       leading: CircleAvatar(
    //         radius: 25.0,
    //         backgroundImage: NetworkImage(picture),
    //       ),
    //       title: Text(widget.booking.clientName),
    //       subtitle: Text(widget.booking.clientEmail),
    //       dense: true,
    //       trailing: Icon(FontAwesomeIcons.arrowCircleRight),
    //       onTap: () {
    //         Navigator.of(context)
    //             .push(MaterialPageRoute(builder: (context) => Request()));
    //       },
    //     ),
    //   ),
    // );
  }
}
