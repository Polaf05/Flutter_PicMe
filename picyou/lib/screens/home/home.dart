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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'request.dart';





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
    _controller = TabController(initialIndex: 0, length: 3, vsync: this);
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
               FontAwesomeIcons.userCircle,
                color: Color.fromRGBO(216, 181, 58, 1.0),
              ),
              label: Text(
                'Logout',
                style: GoogleFonts.roboto(
                  color: Colors.black,
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
              color: Colors.black,
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
          centerTitle: false,
        ),
        body: ListView(children: <Widget>[
          new Column(children: <Widget>[
            Container(
              child: Stack(
                alignment: Alignment.bottomCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image:AssetImage('assets/en.jpg'),
                          )),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 130.0,
                    right: 220.0,
                    child: Container(
                      height: 160.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/en.jpg'),
                          ),
                          border: Border.all(color: Colors.white, width: 6.0)),
                    ),
                  ),
                   Positioned(
                      top: 270,
                      left: 200,
                      child:
                            Row(
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

                              ],
                            ),
                   ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
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
            SizedBox(
              height: 10.0,
            ),
            Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                    Row(
                    children: <Widget>[
                      Icon(Icons.link,
                         size: 20,
                         color: Color.fromRGBO(216, 181, 58, 1.0)),
                        SizedBox(width: 10),
                        Text(
                          name,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_pin,
                          size: 20, color: Color.fromRGBO(216, 181, 58, 1.0)),
                      SizedBox(width: 10),
                      Text(
                        address,
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
                          size: 20, color: Color.fromRGBO(216, 181, 58, 1.0)),
                      SizedBox(width: 10),
                      Text(
                        contact,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
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
                                  Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Reviews",
                                          style: TextStyle(
                                              fontFamily: "BarlowBold",
                                              fontSize: 15.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        Container(
                              padding: EdgeInsets.only(
                                left: 5,
                                right: 5,
                                top: 5,
                                bottom: 0,
                              ),
                            height: MediaQuery.of(context).size.height,
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
               ListView.builder(
           padding: EdgeInsets.zero,
            itemCount: 5,
            shrinkWrap:true,
            itemBuilder:(BuildContext context, int index) => 
            Container(
              width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            child: Card(
              elevation: 2,
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
                        height: 75.5,
                        color: Colors.transparent,
                        child: CircleAvatar(
                         backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                            'assets/en.jpg',
                          ),
                        ),
                      ),
                      SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                          'Monkey D. Luffy',
                          style:
                              GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                        ),
                      Text(
                          'kiben@yahoo.com',
                          style: GoogleFonts.montserrat(fontSize: 14.0)),
                      ],
                    )
                    ],
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child:IconButton(
                      icon: Icon(FontAwesomeIcons.arrowCircleRight),
                      onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Request()));
                              },
                    ),
                              ),
                          ],
                          ),
                        ),
                      ),
                      )
                ),
  ListView.builder(
           padding: EdgeInsets.zero,
            itemCount: 5,
            shrinkWrap:true,
            itemBuilder:(BuildContext context, int index) => 
            Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical:0),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
                ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(216,181,58, 1.0),width: 1),
                  ) ),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                      Container(
                        width: 60,
                        height: 75.5,
                        color: Colors.transparent,
                        child: CircleAvatar(
                         backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                            'assets/en.jpg',
                          ),
                        ),
                      ),
                      SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                            'Monkey D. Luffy',
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      SizedBox(width: 5),
                      Container(
                        child: Text(
                              'luffytaro@gmail.com',
                              style:
                                  GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 10.0,
                                  color: Colors.black38),
                              overflow: TextOverflow.ellipsis,
                        ),
                      ),
                          ],
                        ),
                      SizedBox(height: 7), 
                      Container(
                        width: 240,
                        child: Text(
                            'Bastos yan si kiben Bastos yan si kiben Bastos yan si kiben Bastos yan si kiben Bastos yan si kiben',
                            style: GoogleFonts.montserrat(fontSize: 12.0)),
                      ),
                      SizedBox(height: 7),
                       Container(
                          child: RatingBarIndicator(
                            rating: 2.75,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
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
                  )
            ),
            ],
                ),
                            ),
                ]))
          ]),
          
        ]),
//         body: Stack(
//           children: <Widget>[
//             Center(
//               child: Image.asset(
//                 "assets/bg.png",
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: 1200,
//               ),
//             ),
//             Container(
//               height: double.infinity,
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   double innerWidth = constraints.maxWidth;
//                   return Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Positioned(
//                         top: 200,
//                         bottom: 0,
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           height: 10,
//                           width: innerWidth,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(35),
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.fromLTRB(0, 270, 0, 0),
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               margin: EdgeInsets.only(left: 25),
//                               alignment: Alignment.topLeft,
//                               child: Text(
//                                 username,
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 26,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 3,
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(left: 25),
//                               alignment: Alignment.topLeft,
//                               child: Text(
//                                 email,
//                                 style: GoogleFonts.lato(
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
                      
//                       SizedBox(height: 30),
//                       Column(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.fromLTRB(20, 350, 0, 0),
//                             child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Icon(Icons.link,
//                                       size: 20,
//                                       color: Color.fromRGBO(216, 181, 58, 1.0)),
//                                   Text(
//                                     name,
//                                     style: GoogleFonts.montserrat(
//                                       color: Colors.black,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ]),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                         margin: EdgeInsets.fromLTRB(20, 370, 0, 0),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Icon(Icons.location_pin,
//                                   size: 20,
//                                   color: Color.fromRGBO(216, 181, 58, 1.0)),
//                               Text(
//                                 address,
//                                 style:  GoogleFonts.montserrat(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ]),
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                         margin: EdgeInsets.fromLTRB(20, 390, 0, 0),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Icon(Icons.call,
//                                   size: 20,
//                                   color: Color.fromRGBO(216, 181, 58, 1.0)),
//                               Text(
//                                 contact,
//                                 style:  GoogleFonts.montserrat(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ]),
//                       ),
//                       Container(
//                         margin: EdgeInsets.fromLTRB(180, 210, 0, 0),
//                         child: Column(
//                           children: [
//                             TextButton(
//                               child: Text("Edit Profile",
//                                   style: TextStyle(fontSize: 18.0)),
//                               style: ButtonStyle(
//                                   padding: MaterialStateProperty.all<EdgeInsets>(
//                                       EdgeInsets.fromLTRB(40, 15, 40, 15)),
//                                   foregroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                           Colors.black),
//                                   shape:
//                                       MaterialStateProperty.all<RoundedRectangleBorder>(
//                                           RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(30.0),
//                                               side: BorderSide(
//                                                   color: Color.fromRGBO(
//                                                       216, 181, 58, 1.0))))),
//                               onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => Edit()));
//                               },
//                             ),
                           

//                        Container(
//                          height: 40,
//                          margin: EdgeInsets.fromLTRB(40, 100, 10, 0),
//                          child: LiteRollingSwitch(
//                             value: true,
//                             textOn: 'URGENT',
//                             textOff: 'URGENT',
//                             colorOn:  Color.fromRGBO(216, 181, 58, 1.0),
//                             colorOff: Color.fromRGBO(31, 31, 31, 1.0),
//                             iconOn: Icons.done,
//                             iconOff: FontAwesomeIcons.exclamationCircle,
//                             textSize: 18.0,
//                             onChanged: (bool state) {
//                             },
//                         ),
//                        ),

//                           ],
//                         ),
//                       ),
//                       Stack(
//                         children: [
//                           Positioned(
//                             top: 450,
//                             left: 0,
//                             right: 0,
//                             child: Container(
//                               decoration: new BoxDecoration(
//                                   color: Theme.of(context).primaryColor),
//                               child: new TabBar(
//                                 controller: _controller,
//                                 unselectedLabelColor:
//                                     Color.fromRGBO(237, 237, 237, 1.0),
//                                 indicator: BoxDecoration(
//                                     color: Color.fromRGBO(43, 43, 43, 1.0),
//                                     border: Border(
//                                       top: BorderSide(
//                                           width: 4.0,
//                                           color: Color.fromRGBO(
//                                               216, 181, 58, 1.0)),
//                                     )),
//                                 labelColor: Color.fromRGBO(216, 181, 58, 1.0),
//                                 indicatorSize: TabBarIndicatorSize.tab,
//                                 tabs: [
//                                   Tab(
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text("Gallery",
//                                           style: TextStyle(
//                                               fontFamily: "BarlowBold",
//                                               fontSize: 15.0)),
//                                     ),
//                                   ),
//                                   Tab(
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text("View Request",
//                                           style: TextStyle(
//                                               fontFamily: "BarlowBold",
//                                               fontSize: 15.0)),
//                                     ),
//                                   ),
//                                   Tab(
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text("Reviews",
//                                           style: TextStyle(
//                                               fontFamily: "BarlowBold",
//                                               fontSize: 15.0)),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             top: 500,
//                             left: 0,
//                             right: 0,
//                             child: Container(
//                               padding: EdgeInsets.only(
//                                 left: 16,
//                                 right: 16,
//                                 top: 5,
//                                 bottom: 0,
//                               ),
//                               height: 320,
//                               child: new TabBarView(
//                                 controller: _controller,
//                                 children: <Widget>[
//                    Column(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.fromLTRB(10, 60, 50, 0),
//                         child: Icon(
//                          FontAwesomeIcons.photoVideo,
//                          size: 110,
//                          color: Colors.black12,
//                         ),
//                       ),
//                     SizedBox(height: 30,),
//                     Text(
//                       'No Photos/Videos to show',
//                       style: GoogleFonts.lato(
//                         color:Colors.grey, 
//                         fontSize: 18,
//                       ),
//                     )
//                     ],
//                   ),
//                ListView.builder(
//            padding: EdgeInsets.zero,
//             itemCount: 5,
//             shrinkWrap:true,
//             itemBuilder:(BuildContext context, int index) => 
//             Container(width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
//             child: Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(3.0),
//                 ),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: [
//                       Container(
//                         width: 55.5,
//                         height: 75.5,
//                         color: Colors.transparent,
//                         child: CircleAvatar(
//                          backgroundColor: Colors.transparent,
//                           backgroundImage: AssetImage(
//                             'assets/en.jpg',
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 15.0),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(top: 20),
//                           child: Text(
//                           'Monkey D. Luffy',
//                           style:
//                               GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 18.0),
//                       ),
//                         ),
//                       Text(
//                           'kiben@yahoo.com',
//                           style: GoogleFonts.montserrat(fontSize: 14.0)),
//                       ],
//                     )
//                     ],
//                     ),
//                   Container(
//                     margin: EdgeInsets.only(top: 20),
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//                     child:IconButton(
//                       icon: Icon(FontAwesomeIcons.arrowCircleRight),
//                       onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => Request()));
//                               },
//                     ),
//                               ),
//                           ],
//                           ),
//                         ),
//                       ),
//                       )
//                 ),
//  ListView.builder(
//            padding: EdgeInsets.zero,
//             itemCount: 5,
//             shrinkWrap:true,
//             itemBuilder:(BuildContext context, int index) => 
//             Container(width: MediaQuery.of(context).size.width,
//             height: 200,
//             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
//             child: Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(3.0),
//                 ),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: [
//                       Center(
//                         child: Container(
//                           width: 100,
//                           height: 100,
//                           color: Colors.transparent,
//                           child: CircleAvatar(
//                            backgroundColor: Colors.transparent,
//                             backgroundImage: AssetImage(
//                               'assets/en.jpg',
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 15.0),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                          Container(
//                           margin: EdgeInsets.only(top: 10),
//                         child:Text(
//                         'Monkey D. Luffy',
//                         style:
//                             GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20.0),
//                       ),
//                          ),
//                       SizedBox(height: 7.0),
//                       Container(
//                         width: 180,
//                         padding: EdgeInsets.only(right: 5),
//                         child: Text(
//                             'Bastos yan si kiben asdfndjdkads fjkadbsfkj dsfsdfsdfa fasdfsaf dfsdfa ',
//                             style: GoogleFonts.montserrat(fontSize: 14.0),
//                            ),
//                       ),
//                       SizedBox(height: 7.0),
//                        Container(
//                           child: RatingBarIndicator(
//                             rating: 2.75,
//                             itemBuilder: (context, index) => Icon(
//                               Icons.star,
//                               color: Colors.amber,
//                             ),
//                             itemCount: 5,
//                             itemSize: 25.0,
//                           ),
//                         ),
//                       ],
//                     )
//                     ],
//                     ),
//                 ],
//                 ),
//               ),
//             ),
//             )
//       ),
//             ],
//                 ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Positioned(
//                         top: 150,
//                         left: 0,
//                         right: 230,
//                         child: CircleAvatar(
//                           backgroundColor: Colors.transparent,
//                           backgroundImage: AssetImage('assets/en.jpg'),
//                           radius: 60.0,
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),

      ),
    );
  }
}
