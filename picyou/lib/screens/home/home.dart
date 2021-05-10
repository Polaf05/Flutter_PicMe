import 'package:flutter/material.dart';
import 'package:picyou/services/auth.dart';
import 'package:picyou/screens/home/edit.dart';
import 'package:picyou/services/database.dart';
import 'package:provider/provider.dart';
import 'package:picyou/model/lensmen.dart';
import 'package:picyou/screens/home/lensmen_list.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                        margin: EdgeInsets.fromLTRB(0, 290, 230, 0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              username,
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
                              email,
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
                                  Icon(Icons.link,
                                      size: 20,
                                      color: Color.fromRGBO(216, 181, 58, 1.0)),
                                  Text(
                                    name,
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
                                address,
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
                                contact,
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
                                  GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 150,
                                              childAspectRatio: 1,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      itemCount: gallery.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(gallery[index]),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        );
                                      }),
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
