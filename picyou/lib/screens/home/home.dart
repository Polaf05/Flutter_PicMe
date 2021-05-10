import 'package:flutter/material.dart';
import 'package:picyou/services/auth.dart';
import 'package:picyou/screens/home/edit.dart';
import 'package:picyou/services/database.dart';
import 'package:provider/provider.dart';
import 'package:picyou/model/lensmen.dart';
import 'package:picyou/screens/home/lensmen_list.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';




class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  TabController _controller;

  String username = ' ';
  String name = ' ';
  String address = ' ';
  String contact = ' ';
  String email = ' ';
  dynamic gallery = ' ';
  String displayPicture = '';

  @override
  void initState() {
    _controller = TabController(initialIndex: 0, length: 2, vsync: this);
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
      });
    });
  }

  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return StreamProvider<List<Lensmen>>.value(
      value: DatabaseService().lensmen,
      initialData: List(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Color.fromRGBO(216, 181, 58, 1.0),
              ),
              label: Text(
                'Logout',
                style: TextStyle(
                  color: Color.fromRGBO(247, 247, 232, 1.0),
                ),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
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
              child: Image.asset(
                "assets/bg.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 1200,
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
                        margin: EdgeInsets.fromLTRB(0, 270, 0, 0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 25),
                              alignment: Alignment.topLeft,
                              child: Text(
                                username,
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
                                email,
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 350, 0, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.link,
                                      size: 20,
                                      color: Color.fromRGBO(216, 181, 58, 1.0)),
                                  Text(
                                    name,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 370, 0, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.location_pin,
                                  size: 20,
                                  color: Color.fromRGBO(216, 181, 58, 1.0)),
                              Text(
                                address,
                                style:  GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 390, 0, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.call,
                                  size: 20,
                                  color: Color.fromRGBO(216, 181, 58, 1.0)),
                              Text(
                                contact,
                                style:  GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(180, 210, 0, 0),
                        child: Column(
                          children: [
                            TextButton(
                              child: Text("Edit Profile",
                                  style: TextStyle(fontSize: 18.0)),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.fromLTRB(40, 15, 40, 15)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  shape:
                                      MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              side: BorderSide(
                                                  color: Color.fromRGBO(
                                                      216, 181, 58, 1.0))))),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Edit()));
                              },
                            ),
                           

                       Container(
                         height: 40,
                         margin: EdgeInsets.fromLTRB(40, 100, 10, 0),
                         child: LiteRollingSwitch(
                            value: true,
                            textOn: 'URGENT',
                            textOff: 'URGENT',
                            colorOn:  Color.fromRGBO(216, 181, 58, 1.0),
                            colorOff: Color.fromRGBO(31, 31, 31, 1.0),
                            iconOn: Icons.done,
                            iconOff: FontAwesomeIcons.exclamationCircle,
                            textSize: 18.0,
                            onChanged: (bool state) {
                            },
                        ),
                       ),

                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Positioned(
                            top: 450,
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
                                          color: Color.fromRGBO(
                                              216, 181, 58, 1.0)),
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
                                      child: Text("View Request",
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
                            top: 500,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 5,
                                bottom: 0,
                              ),
                              height: 320,
                              child: new TabBarView(
                                controller: _controller,
                                children: <Widget>[
                   Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 60, 50, 0),
                        child: Icon(
                         FontAwesomeIcons.photoVideo,
                         size: 110,
                         color: Colors.black12,
                        ),
                      ),
                    SizedBox(height: 30,),
                    Text(
                      'No Photos/Videos to show',
                      style: GoogleFonts.lato(
                        color:Colors.grey, 
                        fontSize: 18,
                      ),
                    )
                    ],
                  ),
                                  // GridView.builder(
                                  //     gridDelegate:
                                  //         SliverGridDelegateWithMaxCrossAxisExtent(
                                  //             maxCrossAxisExtent: 150,
                                  //             childAspectRatio: 1,
                                  //             crossAxisSpacing: 10,
                                  //             mainAxisSpacing: 10),
                                  //     itemCount: gallery.length,
                                  //     itemBuilder: (BuildContext ctx, index) {
                                  //       return Container(
                                  //         alignment: Alignment.center,
                                  //         decoration: BoxDecoration(
                                  //           color: Colors.amber,
                                  //           borderRadius:
                                  //               BorderRadius.circular(15),
                                  //           image: DecorationImage(
                                  //             image:
                                  //                 NetworkImage(gallery[index]),
                                  //             fit: BoxFit.fill,
                                  //           ),
                                  //         ),
                                  //       );
                                  //     }),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: new ListTile(
                                          leading: const Icon(Icons.person),
                                          title: new TextField(
                                            decoration: const InputDecoration(
                                                hintText: 'Reniel Avellano'),
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                          // Container(
                          //     padding: EdgeInsets.zero,
                          //     margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          //     height: 100,
                          //     child: GestureDetector(
                          //       onTap: () {
                          //       },
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                          //         child: Card(
                          //           clipBehavior: Clip.antiAlias,
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(5),
                          //           ),
                          //           child: Row(
                          //             children: [
                          //               Container(
                          //                 margin: EdgeInsets.fromLTRB(10, 0, 10, 170),
                          //                 height: 100,
                          //                 width: 120,
                          //                 decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(8),
                          //                   color: Colors.black,
                          //                   image: DecorationImage(
                          //                     fit: BoxFit.cover,
                          //                     image: AssetImage('assets/11.jpg'),
                          //                   ),
                          //                 ),
                          //               ),
                          //               Flexible(
                          //                 child: Padding(
                          //                   padding: const EdgeInsets.all(12),
                          //                   child: Column(
                          //                     crossAxisAlignment: CrossAxisAlignment.start,
                          //                     children: [
                          //                       Text(
                          //                       'Monkey D, Luffy',
                          //                         overflow: TextOverflow.ellipsis,
                          //                         style: GoogleFonts.poppins(
                          //                           fontSize: 20,
                          //                           fontWeight: FontWeight.bold,
                          //                         ),
                          //                       ),
                          //                       SizedBox(height: 7),
                          //                       Row(
                          //                         children: [
                          //                           Icon(
                          //                             Icons.email,
                          //                             color: Color.fromRGBO(216, 181, 58, 1.0),
                          //                             size: 15,
                          //                           ),
                          //                           SizedBox(width: 5),
                          //                           Text('payraclea19@gmail.com'),
                          //                         ],
                          //                       ),
                          //                       SizedBox(height: 5),
                          //                       Row(
                          //                         children: [
                          //                           Icon(
                          //                             Icons.location_on,
                          //                             color: Color.fromRGBO(216, 181, 58, 1.0),
                          //                             size: 15,
                          //                           ),
                          //                           SizedBox(width: 5),
                          //                           Text('Tondo Manila'),
                          //                         ],
                          //                       ),
                          //                       SizedBox(height: 5),
                          //                       Row(
                          //                         children: [
                          //                           Icon(
                          //                             Icons.call,
                          //                             color: Color.fromRGBO(216, 181, 58, 1.0),
                          //                             size: 15,
                          //                           ),
                          //                           SizedBox(width: 5),
                          //                           Text('09568076691'),
                          //                         ],
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               )
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                            


                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 150,
                        left: 0,
                        right: 230,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/en.jpg'),
                          radius: 60.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
