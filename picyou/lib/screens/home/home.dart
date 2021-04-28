import 'package:flutter/material.dart';
import 'package:picyou/services/auth.dart';
import 'package:picyou/screens/home/edit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatelessWidget {
  @override
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
            },
          )
        ],
        leading: GestureDetector(
          onTap: () {},
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
                      margin: EdgeInsets.fromLTRB(0, 290, 290, 0),
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
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.location_pin,
                                      size: 20,
                                      color: Color.fromRGBO(216, 181, 58, 1.0)),
                                  Text('National Capital Republic'),
                                ]),
                          ),
                          SizedBox(height: 5),
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.cake_outlined,
                                      size: 20,
                                      color: Color.fromRGBO(216, 181, 58, 1.0)),
                                  Text('August 5,2069'),
                                  Icon(Icons.call,
                                      size: 20,
                                      color: Color.fromRGBO(216, 181, 58, 1.0)),
                                  Text('0969212143'),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(240, 220, 0, 0),
                      child: Column(
                        children: [
                          TextButton(
                            child: Text("Edit Profile",
                                style: TextStyle(fontSize: 18.0)),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.fromLTRB(60, 15, 60, 15)),
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
                      right: 280,
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
    );
  }
}
