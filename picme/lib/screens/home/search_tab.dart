import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:picme/models/user.dart';
import 'package:picme/screens/home/book.dart';
import 'package:picme/models/lensman.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picme/screens/home/edit.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/services/database.dart';
import 'package:picme/screens/home/search_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:math';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

int toggle = 0;

class _SearchTabState extends State<SearchTab>
    with SingleTickerProviderStateMixin {
  AnimationController _con;
  TextEditingController _textEditingController;
  QuerySnapshot snapshotData;
  bool isExecuted = false;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 375),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GetBuilder<DataController>(
        init: DataController(),
        builder: (val) {
          return Container(
            padding: EdgeInsets.all(20.0),
            child: Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              alignment: Alignment(-1.0, 0.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 375),
                height: 52.0,
                width: (toggle == 0) ? 52.0 : MediaQuery.of(context).size.width,
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(237, 237, 237, 1.0),
                      spreadRadius: -10.0,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 375),
                      top: 0,
                      right: 7.0,
                      curve: Curves.easeOut,
                      child: AnimatedOpacity(
                        opacity: (toggle == 0) ? 0.0 : 1.0,
                        duration: Duration(milliseconds: 200),
                        child: Container(
                          padding: EdgeInsets.all(0.5),
                          decoration: BoxDecoration(
                            color: Color(0xffF2F3F7),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: AnimatedBuilder(
                            child: IconButton(
                                icon: Icon(FontAwesomeIcons.timesCircle,
                                    color: Color.fromRGBO(31, 31, 31, 1.0),
                                    size: 24.0),
                                onPressed: () {
                                  setState(() {
                                    isExecuted = false;
                                    _textEditingController.text = "";
                                  });
                                }),
                            builder: (context, widget) {
                              return Transform.rotate(
                                angle: _con.value * 2.0 * pi,
                                child: widget,
                              );
                            },
                            animation: _con,
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 375),
                      left: (toggle == 0) ? 20.0 : 40.0,
                      curve: Curves.easeOut,
                      top: 8.0,
                      child: AnimatedOpacity(
                        opacity: (toggle == 0) ? 0.0 : 1.0,
                        duration: Duration(milliseconds: 200),
                        child: Container(
                          height: 28.0,
                          width: 250.0,
                          child: TextField(
                            onSubmitted: (value) {
                              val
                                  .queryData(_textEditingController.text)
                                  .then((value) {
                                snapshotData = value;
                                setState(() {
                                  isExecuted = true;
                                });
                              });
                            },
                            textInputAction: TextInputAction.search,
                            controller: _textEditingController,
                            cursorRadius: Radius.circular(20.0),
                            cursorWidth: 2.0,
                            cursorHeight: 30.0,
                            cursorColor: Colors.yellow,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: 'Search for lensman',
                              labelStyle: GoogleFonts.poppins(
                                color: Color(0xff5B5B5B),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                              ),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      child: IconButton(
                        splashRadius: 22.0,
                        icon: FaIcon(
                          FontAwesomeIcons.search,
                          color: Color.fromRGBO(216, 181, 58, 1.0),
                          size: 28.0,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              if (toggle == 0) {
                                toggle = 1;
                                _con.forward();
                              } else {
                                toggle = 0;
                                _textEditingController.clear();
                                _con.reverse();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: isExecuted
            ? SearchData(snapshotData: snapshotData)
            : Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(150, 200, 150, 0),
                    // child: Icon(
                    //  FontAwesomeIcons.search,
                    //  size: 110,
                    //  color: Colors.black12,
                    // ),
                    child: Image.asset(
                      'assets/logos.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'No Lensman Found/ Matched',
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
      )
    ]);
  }
}
