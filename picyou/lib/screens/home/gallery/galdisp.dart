import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view.dart';


class GalleryDisp extends StatefulWidget {
  @override
  _GalleryDispState createState() => _GalleryDispState();
}

class _GalleryDispState extends State<GalleryDisp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:   Expanded(
                child: GridView(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  children: [1, 2, 3, 4, 5, 6, 7, 8, 9]
                      .map((e) => FocusedMenuHolder(
                        menuWidth: MediaQuery.of(context).size.width*0.50,
                        blurSize: 5.0,
                        menuItemExtent: 45,
                        menuBoxDecoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        duration: Duration(milliseconds: 100),
                        animateMenuItems: true,
                        blurBackgroundColor: Colors.black54,
                        bottomOffsetHeight: 100,
                        openWithTap: true,
                        menuItems: <FocusedMenuItem>[
                          FocusedMenuItem(title: Text("Open",style: GoogleFonts.lato(fontSize: 16)),trailingIcon: Icon(Icons.open_in_new) ,onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPic()));
                          }),
                          FocusedMenuItem(title: Text("Replace",style: GoogleFonts.lato(fontSize: 16)),trailingIcon: Icon(FontAwesomeIcons.camera) ,onPressed: (){}),
                          FocusedMenuItem(title: Text("Delete",style: GoogleFonts.lato(fontSize: 16, color:  Color.fromRGBO(216, 181, 58, 1.0))),trailingIcon: Icon(Icons.delete,color:  Color.fromRGBO(216, 181, 58, 1.0)) ,onPressed: (){}),
                        ],
                        onPressed: (){},
                        child: Card(
                              child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: AssetImage("assets/$e.jpg"), 
                            fit: BoxFit.cover,
                          ),
                        ),
                        ),
                            ),
                      ))
                      .toList(),
                ),
              ),
    );
  }
}
