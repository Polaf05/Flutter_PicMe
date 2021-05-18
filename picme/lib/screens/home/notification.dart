import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:picme/models/booking.dart';
import 'package:picme/models/user.dart';
import 'package:picme/screens/home/book.dart';
import 'package:picme/models/lensman.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picme/screens/home/edit.dart';
import 'package:picme/screens/home/rate.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/services/database.dart';
import 'package:picme/screens/home/lensman_tile.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NotificationTab extends StatefulWidget {
  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Booking>>.value(
      value: DatabaseService().booking,
      initialData: List(),
      child: Scaffold(
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
              child: RateTile(),
            ),
          ],
        ),
      ),
    );
  }
}
