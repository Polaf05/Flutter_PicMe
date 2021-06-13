import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picme/models/lensman.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/screens/home/home.dart';
import 'package:picme/screens/home/client.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:picme/services/database.dart';
import 'package:flutter/services.dart';
import 'package:picme/screens/wrapper.dart';

class Edit extends StatefulWidget {
  final dynamic user;

  Edit({this.user});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  DatabaseService _db = DatabaseService();

  String name = "";
  String email = "";
  String address = "";
  String contact = "";
  String display = "";
  String cover = "";
  String bio = "";
  String id = "";

  TextEditingController _name = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  TextEditingController _contact = new TextEditingController();
  TextEditingController _bio = new TextEditingController();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        name = widget.user.name;
        email = widget.user.email;
        address = widget.user.address;
        contact = widget.user.contact;
        display = widget.user.display;
        cover = widget.user.cover;
        bio = widget.user.bio;
        id = widget.user.id;

        _name.text = name;
        _contact.text = contact;
        _address.text = address;
        _bio.text = bio;
      });
    });
  }

  uploadImage(int loc) async {
    final _picker = ImagePicker();

    PickedFile image;

    //Select Image
    image = await _picker.getImage(source: ImageSource.gallery);
    dynamic file = File(image.path);

    if (image != null) {
      String path = await _db.uploadImageToFirebase(widget.user.email, file);

      if (loc == 1) {
        setState(() {
          cover = path;
        });
      } else {
        setState(() {
          display = path;
        });
      }
    } else {
      print("No path Recieved");
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
                            height: 20,
                          ),
                          FlatButton(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            color: Color.fromRGBO(237, 237, 237, 1.0),
                            onPressed: () async {
                              await _db.updateUserInformation(id, cover,
                                  display, name, address, contact, bio);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Wrapper()),
                                (Route<dynamic> route) => false,
                              );
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
                    child: GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
                          radius: 60,
                          child: Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                            size: 50,
                          ),
                        )),
                  ),
                ]));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Wrapper()));
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
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
                    image: NetworkImage(cover),
                  )),
                ),
              )
            ],
          ),
          Positioned(
            top: 150,
            left: 300,
            child: GestureDetector(
              onTap: () async {
                uploadImage(1);
              },
              child: Container(
                height: 40,
                width: 40,
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(216, 181, 58, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
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
                                image: NetworkImage(display),
                              ),
                              border:
                                  Border.all(color: Colors.white, width: 6.0)),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 260,
                      left: 220,
                      child: GestureDetector(
                        onTap: () async {
                          uploadImage(2); // ayaw gumana prettier
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(216, 181, 58, 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
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
                                    controller: _name,
                                    onChanged: (_name) {
                                      name = _name;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: 'Fullname',
                                      labelText: 'Name',
                                      prefixIcon: const Icon(
                                        Icons.person_add_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    controller: _bio,
                                    onChanged: (_bio) {
                                      bio = _bio;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: 'Enter Bio',
                                      labelText: 'Bio',
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    controller: _address,
                                    onChanged: (_address) {
                                      address = _address;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: 'Enter Address',
                                      labelText: 'Address',
                                      prefixIcon: const Icon(
                                        Icons.location_on_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _contact,
                                    onChanged: (_contact) {
                                      contact = _contact;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: 'Enter Contact',
                                      labelText: 'Contact Number',
                                      prefixIcon: const Icon(
                                        Icons.call_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
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
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Wrapper()),
                                          (Route<dynamic> route) => false,
                                        );
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
                                      onPressed: () {
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
