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

class NotificationTab extends StatefulWidget {
  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: [ 
        Container(
              margin: EdgeInsets.fromLTRB(0,60,130,20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Notifications',
                    style:
                        GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 28.0),
                  ),
                ],
              ),
            ),
        Container(
           margin: EdgeInsets.only(top: 68),
          child: ListView.builder(
          itemCount: 5,
          shrinkWrap:true,
          itemBuilder:(BuildContext context, int index) => 
          Container(width: MediaQuery.of(context).size.width,
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
                        backgroundImage: AssetImage(
                          'assets/en.jpg',
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      'Monkey D. Luffy',
                      style:
                          GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Text(
                        'luffy@example.com',
                        style: GoogleFonts.montserrat(fontSize: 12.0)),
                    Text(
                        'Done',
                        style: GoogleFonts.montserrat(fontSize: 10.0, backgroundColor: Colors.grey[100], color: Colors.green)),
                    ],
                  )
                  ],
                  ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: FlatButton(
                    onPressed: (){},
                    color: Color.fromRGBO(216, 181, 58, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                    child: Text('Rate', style: GoogleFonts.lato(
                      color: Colors.white,
                    ),),
                  ),
                )
              ],
              ),
            ),
          ),
          )
      ),
        ),
      ],
      ),
    );
  }
}
