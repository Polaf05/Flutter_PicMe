import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picyou/screens/home/home.dart';

class ViewPic extends StatelessWidget {
  final String picture;

  ViewPic({this.picture});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: NetworkImage(picture),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
                  radius: 20,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ))),
      ],
    );
  }
}
