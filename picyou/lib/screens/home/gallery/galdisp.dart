import 'dart:io';

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view.dart';
import 'package:picyou/services/database.dart';
import 'package:picyou/services/auth.dart';
import 'package:image_picker/image_picker.dart';

class GalleryDisp extends StatefulWidget {
  @override
  _GalleryDispState createState() => _GalleryDispState();
}

class _GalleryDispState extends State<GalleryDisp> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  dynamic gallery = ['', '', '', '', '', '', '', '', ''];
  String email = '';
  String uid = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dynamic id = _auth.getCurrentUser();
      dynamic fetch = await _db.fetchUserData(id.uid);
      setState(() {
        gallery = fetch.gallery;
        email = fetch.email;
        uid = id.uid;
      });
      print(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    uploadImage(int loc) async {
      final _picker = ImagePicker();

      PickedFile image;

      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      dynamic file = File(image.path);

      if (image != null) {
        String path = await _db.uploadImageToFirebase(email, file);

        setState(() {
          gallery[loc] = path;
        });

        await _db.updateGallery(loc, uid, gallery);
      } else {
        print("No path Recieved");
      }
    }

    deleteImage(int loc) async {
      setState(() {
        gallery[loc] =
            'https://firebasestorage.googleapis.com/v0/b/picme-4c5ea.appspot.com/o/Assets%2Fdefault%20dp%2F360_F_410437733_hdq4Q3QOH9uwh0mcqAhRFzOKfrCR24Ta.jpg?alt=media&token=b1ae5147-b094-4e53-b7ac-518a6f4c218c';
      });

      await _db.updateGallery(loc, uid, gallery);
    }

    return Container(
      child: Row(
        children: [
          Expanded(
            child: GridView(
              physics: BouncingScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              children: [0, 1, 2, 3, 4, 5, 6, 7, 8]
                  .map((e) => FocusedMenuHolder(
                        menuWidth: MediaQuery.of(context).size.width * 0.50,
                        blurSize: 5.0,
                        menuItemExtent: 45,
                        menuBoxDecoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        duration: Duration(milliseconds: 100),
                        animateMenuItems: true,
                        blurBackgroundColor: Colors.black54,
                        bottomOffsetHeight: 100,
                        openWithTap: true,
                        menuItems: <FocusedMenuItem>[
                          FocusedMenuItem(
                              title: Text("Open",
                                  style: GoogleFonts.lato(fontSize: 16)),
                              trailingIcon: Icon(Icons.open_in_new),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewPic(picture: gallery[e])));
                              }),
                          FocusedMenuItem(
                              title: Text("Replace",
                                  style: GoogleFonts.lato(fontSize: 16)),
                              trailingIcon: Icon(FontAwesomeIcons.camera),
                              onPressed: () async {
                                await uploadImage(e);
                              }),
                          FocusedMenuItem(
                              title: Text("Delete",
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color:
                                          Color.fromRGBO(216, 181, 58, 1.0))),
                              trailingIcon: Icon(Icons.delete,
                                  color: Color.fromRGBO(216, 181, 58, 1.0)),
                              onPressed: () async {
                                await deleteImage(e);
                              }),
                        ],
                        onPressed: () {},
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(gallery[e]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
