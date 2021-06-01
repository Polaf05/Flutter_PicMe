import 'package:flutter/material.dart';
import 'package:picme/models/user.dart';
import 'package:picme/screens/home/book.dart';
import 'package:picme/models/lensman.dart';
import 'package:picme/screens/home/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShowDetails extends StatefulWidget {
  final Lensman lens;
  final Client user;

  ShowDetails({this.lens, this.user});

  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails>
    with TickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    _controller = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
          "Profile",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset("assets/bg.png",
                fit: BoxFit.cover, width: double.infinity, height: 1024),
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
                      top: 200,
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
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 135, 0, 0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 145, 0, 0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 25),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.lens.name,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 25),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.lens.email,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 20.0),
                          // Center(
                          //   child: Container(
                          //     margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          //     width: 350,
                          //     decoration: BoxDecoration(
                          //         border: Border.all(
                          //             color: Color.fromRGBO(216, 181, 58, 1.0),
                          //             width: 3.0)),
                          //     child: Container(
                          //         padding: EdgeInsets.fromLTRB(20, 20, 15, 20),
                          //         child: Text(
                          //           'AASBDHSABDIASHBDIDBASIUCBASIUCBASUICBASUICBASUCBASUICBSUCBASICUABS',
                          //           style: GoogleFonts.lato(fontSize: 16.0),
                          //           textAlign: TextAlign.center,
                          //         )),
                          //   ),
                          // ),
                          Container(
                            // margin: EdgeInsets.only(top:230),
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.person,
                                        size: 20,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0)),
                                    SizedBox(width: 10),
                                    Text(
                                      widget.lens.username,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.location_pin,
                                        size: 20,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0)),
                                    SizedBox(width: 10),
                                    Text(
                                      widget.lens.address,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.call,
                                        size: 20,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0)),
                                    SizedBox(width: 10),
                                    Text(
                                      widget.lens.contact,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(180, 0, 0, 350),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            color: Color.fromRGBO(216, 181, 58, 1.0),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Book(
                                        lens: widget.lens, user: widget.user)),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: 0,
                      right: 230,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(widget.lens.display),
                        radius: 60.0,
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 500,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: new BoxDecoration(
                                color: Theme.of(context).primaryColor),
                            child: new TabBar(
                              controller: _controller,
                              unselectedLabelColor:
                                  Color.fromRGBO(237, 237, 237, 1.0),
                              indicator: BoxDecoration(
                                  color: Color.fromRGBO(43, 43, 43, 1.0),
                                  border: Border(
                                    top: BorderSide(
                                        width: 4.0,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0)),
                                  )),
                              labelColor: Color.fromRGBO(216, 181, 58, 1.0),
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: [
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Gallery",
                                        style: TextStyle(
                                            fontFamily: "BarlowBold",
                                            fontSize: 15.0)),
                                  ),
                                ),
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Review and Ratings",
                                        style: TextStyle(
                                            fontFamily: "BarlowBold",
                                            fontSize: 15.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 550,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 5,
                              bottom: 0,
                            ),
                            height: 320,
                            child: new TabBarView(
                              controller: _controller,
                              children: <Widget>[
                                GridView.builder(
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 150,
                                            childAspectRatio: 1,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                    itemCount: widget.lens.gallery.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                widget.lens.gallery[index]),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    }),
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: 5,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          child: Card(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                bottom: BorderSide(
                                                    color: Color.fromRGBO(
                                                        216, 181, 58, 1.0),
                                                    width: 1),
                                              )),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 18.0,
                                                  vertical: 18.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 75.5,
                                                        color:
                                                            Colors.transparent,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          backgroundImage:
                                                              AssetImage(
                                                            'assets/en.jpg',
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 15.0),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Monkey D. Luffy',
                                                                style: GoogleFonts.lato(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18.0),
                                                              ),
                                                              SizedBox(
                                                                  width: 5),
                                                              Container(
                                                                child: Text(
                                                                  'luffytaro@gmail.com',
                                                                  style: GoogleFonts.lato(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          10.0,
                                                                      color: Colors
                                                                          .black38),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 7),
                                                          Container(
                                                            width: 255,
                                                            child: Text(
                                                                'Bastos yan si kiben Bastos yan si kiben Bastos yan si kiben Bastos yan si kiben Bastos yan si kiben',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontSize:
                                                                            12.0)),
                                                          ),
                                                          SizedBox(height: 7),
                                                          Container(
                                                            child:
                                                                RatingBarIndicator(
                                                              rating: 2.75,
                                                              itemBuilder:
                                                                  (context,
                                                                          index) =>
                                                                      Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              itemCount: 5,
                                                              itemSize: 20.0,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                              ],
                            ),
                          ),
                        ),
                      ],
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
