import 'package:flutter/material.dart';
import 'package:picme/models/lensman.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/screens/home/home.dart';
import 'package:picme/screens/home/client.dart';
import 'package:google_fonts/google_fonts.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
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
                                Navigator.of(context).pop();
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
                          onTap: () {
                          },
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
            ])
          );
        },
      );
    }

    final AuthService _auth = AuthService();
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
                    image: AssetImage('assets/1.jpg'),
                  )),
                ),
              )
            ],
          ),
          Positioned(
            top: 150,
            left: 300,
            child: GestureDetector(
              onTap: () {
              
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
                                image: AssetImage('assets/11.jpg'),
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
                                      hintText: 'Enter Company Name',
                                      labelText: 'Company Name',
                                      prefixIcon: const Icon(
                                        Icons.house_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
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
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: 'Enter Email',
                                      labelText: 'Email',
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
                                      onPressed: () {},
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
