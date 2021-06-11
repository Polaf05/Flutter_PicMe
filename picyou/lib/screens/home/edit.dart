import 'package:flutter/material.dart';
import 'package:picyou/services/auth.dart';
import 'package:picyou/screens/home/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picyou/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class Edit extends StatefulWidget {
  // final dynamic user;
  // Edit({this.user});
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  String username = ' ';
  String name = ' ';
  String address = ' ';
  String contact = ' ';
  String email = ' ';
  dynamic gallery = ' ';
  String displayPicture = ' ';
  String coverPicture = ' ';
  String cuser = ' ';
  String cname = ' ';
  String cadd = ' ';
  String ccon = ' ';
  String cemail = ' ';
  bool urgent = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dynamic id = _auth.getCurrentUser();
      dynamic fetch = await _db.fetchUserData(id.uid);
      setState(() {
        username = fetch.username;
        name = fetch.name;
        address = fetch.address;
        contact = fetch.contact;
        email = fetch.email;
        gallery = fetch.gallery;
        displayPicture = fetch.displayPicture;
        coverPicture = fetch.coverPhoto;
        cuser = fetch.username;
        cname = fetch.name;
        cadd = fetch.address;
        ccon = fetch.contact;
        cemail = fetch.email;
        coverPicture = fetch.coverPicture;
        urgent = fetch.urgent;
      });
    });
  }

  uploadImage(int loc) async {
    final _picker = ImagePicker();
    PickedFile image;

    //checkPermission
    //SelectImage
    image = await _picker.getImage(source: ImageSource.gallery);
    dynamic file = File(image.path);
    if (image != null) {
      //upload firebase
      String path = await _db.uploadImageToFirebase(email, file);
      if (loc == 1) {
        setState(() {
          coverPicture = path;
        });
      } else {
        setState(() {
          displayPicture = path;
        });
      }
    } else {
      print("no path");
    }
  }

  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Stack(
                overflow: Overflow.visible,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
                      child: Column(
                        children: [
                          Text(
                            ' Successfully Saved!!',
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Your request sent successfully, wait for confirmation.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FlatButton(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            color: Color.fromRGBO(237, 237, 237, 1.0),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Home()));
                            },
                            child: Text(
                              'Proceed',
                              style: TextStyle(
                                color: Color.fromRGBO(31, 31, 31, 1.0),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: -60,
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
                        radius: 60,
                        child: Icon(
                          Icons.thumb_up_alt_outlined,
                          color: Colors.white,
                          size: 50,
                        ),
                      )),
                ],
              ));
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Home()));
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
            size: 32,
          ),
        ),
        title: Text(
          " Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(coverPicture),
                  )),
                ),
              )
            ],
          ),
          Positioned(
            top: 170,
            left: 330,
            child: Container(
              height: 40,
              width: 40,
              child: IconButton(
                icon: Icon(Icons.add_a_photo),
                color: Colors.white,
                onPressed: () async {
                  uploadImage(1);
                },
              ),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(216, 181, 58, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          Container(
            height: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double innerWidth = constraints.maxWidth;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 230,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 10,
                        width: innerWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 170,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          height: 130.0,
                          width: 130.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(displayPicture),
                              ),
                              border:
                                  Border.all(color: Colors.white, width: 6.0)),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 260,
                      left: 220,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(216, 181, 58, 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        child: IconButton(
                          icon: Icon(Icons.add_a_photo),
                          color: Colors.white,
                          onPressed: () async {
                            uploadImage(2);
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 250),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                        child: Center(
                          child: Form(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: username,
                                      labelText: 'Company Name',
                                      prefixIcon: const Icon(
                                        Icons.house_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      setState(() => username = val);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: name,
                                      labelText: 'Fullname',
                                      prefixIcon: const Icon(
                                        Icons.person_add_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      setState(() => name = val);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: email,
                                      labelText: 'Enter Email',
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: address,
                                      labelText: 'Enter Address',
                                      prefixIcon: const Icon(
                                        Icons.location_on_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      setState(() => address = val);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: contact,
                                      labelText: 'Contact Number',
                                      prefixIcon: const Icon(
                                        Icons.call_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      setState(() => contact = val);
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 10, 30, 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      color: Color.fromRGBO(237, 237, 237, 1.0),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Home()));
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(31, 31, 31, 1.0),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      padding:
                                          EdgeInsets.fromLTRB(35, 10, 35, 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      color: Color.fromRGBO(31, 31, 31, 1.0),
                                      onPressed: () async {
                                        await _db.updateData(
                                            username,
                                            name,
                                            address,
                                            contact,
                                            email,
                                            gallery,
                                            displayPicture,
                                            coverPicture,
                                            urgent);
                                        _showMyDialog();
                                      },
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
