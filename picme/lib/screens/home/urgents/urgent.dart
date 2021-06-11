import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:picme/models/booking.dart';
import 'package:picme/models/user.dart';
import 'package:picme/screens/home/book.dart';
import 'package:picme/models/lensman.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picme/screens/home/edit.dart';
import 'package:picme/screens/home/rate.dart';
import 'package:picme/screens/home/urgents/urgent_list.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/services/database.dart';
import 'package:picme/screens/home/lensman_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UrgentTab extends StatefulWidget {
  @override
  _UrgentTabState createState() => _UrgentTabState();
}

class _UrgentTabState extends State<UrgentTab> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Lensman>>.value(
        value: DatabaseService().urgent,
        initialData: List(),
        child: UrgentList());
  }
}
