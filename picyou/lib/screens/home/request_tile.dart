import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:picyou/model/booking.dart';
import 'package:picyou/services/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'request.dart';

import 'package:picyou/services/auth.dart';

class RequestTile extends StatefulWidget {
  final Booking booking;

  RequestTile({this.booking});

  @override
  _RequestTileState createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  String def_pic =
      "https://firebasestorage.googleapis.com/v0/b/picme-4c5ea.appspot.com/o/Assets%2Fdefault%20dp%2F360_F_410437733_hdq4Q3QOH9uwh0mcqAhRFzOKfrCR24Ta.jpg?alt=media&token=b1ae5147-b094-4e53-b7ac-518a6f4c218c";
  String picture = ' ';
  final DatabaseService _db = DatabaseService();
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print(widget.booking.clientId);
      dynamic fetch = await _db.fetchClientData(widget.booking.clientId);
      setState(() {
        picture = fetch.display;
      });
      print(picture);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(picture),
          ),
          title: Text(widget.booking.clientName),
          subtitle: Text(widget.booking.clientEmail),
          dense: true,
          trailing: Icon(FontAwesomeIcons.arrowCircleRight),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Request()));
          },
        ),
      ),
    );
  }
}
