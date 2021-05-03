import 'package:flutter/material.dart';
import 'package:picyou/services/auth.dart';
import 'package:picyou/screens/home/edit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  TabController tb;

  @override
  void initState() {
    tb = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
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
              print("worki");
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
          style: TextStyle(
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
              "assets/backg.png",
              fit: BoxFit.contain,
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
                      margin: EdgeInsets.fromLTRB(0, 290, 230, 0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Kiben Butal",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "polo@admin.com",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 350, 0, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.home,
                                    size: 20,
                                    color: Color.fromRGBO(216, 181, 58, 1.0)),
                                Text(
                                  "Butal Events Place",
                                  style: TextStyle(
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
                              "Gagalangin Tondo, Manila",
                              style: TextStyle(
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
                              "09213232076",
                              style: TextStyle(
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
                        ],
                      ),
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

                    //               DefaultTabController(

                    //   length: 3,
                    //   child: Scaffold(
                    //     appBar: AppBar(
                    //       bottom: TabBar(
                    //         tabs: [
                    //           Tab(icon: Icon(Icons.directions_car)),
                    //           Tab(icon: Icon(Icons.directions_transit)),
                    //           Tab(icon: Icon(Icons.directions_bike)),
                    //         ],
                    //       ),
                    //       title: Text('Tabs Demo'),
                    //     ),
                    //     body: TabBarView(
                    //       children: [
                    //         Icon(Icons.directions_car),
                    //         Icon(Icons.directions_transit),
                    //         Icon(Icons.directions_bike),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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

// TabBarView(
//             controller: tb,
//             children: <Widget>[
//               Text("Pogi ni Pau"),
//               Text("Sobrang pogi ni pau")
//             ],
//           ),
// 
