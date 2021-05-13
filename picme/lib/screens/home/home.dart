import 'package:flutter/material.dart';
import 'package:picme/main.dart';
import 'package:picme/models/lensman.dart';
import 'package:picme/screens/home/search_tab.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/services/database.dart';
import 'package:provider/provider.dart';
import 'package:picme/screens/home/lensman_list.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:picme/screens/home/client.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

import 'client.dart';
import 'search_tab.dart';
import 'notification.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
     Stack(
        children: <Widget>[
          //  Container(
          //    height: 52,
          //     margin: const EdgeInsets.fromLTRB(16, 45, 16, 16),
          //     padding: const EdgeInsets.symmetric(horizontal: 8),
          //     child: TextFormField(
          //       controller: TextEditingController(),
          //          decoration: InputDecoration(
          //          border: OutlineInputBorder(
          //              borderRadius:
          //                   BorderRadius.circular(12.0),
          //                   borderSide: BorderSide(
          //                   color: Color.fromRGBO(216, 181, 58, 1.0))),
          //                   hintText: 'Search Lensman',
          //                   hintStyle: GoogleFonts.raleway(color: Colors.grey, fontSize: 20),
          //                   prefixIcon: const Icon(Icons.search,
          //                   color: Color.fromRGBO(216, 181, 58, 1.0),
          //                     ),
          //                   ),
          //               ),
          //     ),
                                           
         
          Container(
          margin: EdgeInsets.fromLTRB(30,60,30,20),
          width: double.infinity,
          height: 170.0,
          child: Carousel(
            dotSize: 4.0,
            dotBgColor: Colors.transparent,
            dotColor: Color.fromRGBO(204, 154, 72, 1.0),
            indicatorBgPadding: 5.0,
            dotSpacing: 15.0,
            dotVerticalPadding: 5.0,
            images: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/nct.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/en.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/bts.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),

   Container(
     width: 500,
     margin: EdgeInsets.only(top: 250),
      child: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                ButtonsTabBar(
                  buttonMargin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  contentPadding: EdgeInsets.fromLTRB(40, 0, 45, 0),
                  backgroundColor: Color.fromRGBO(216, 181, 58, 1.0),
                  unselectedBackgroundColor: Color.fromRGBO(237, 237, 237, 1.0),
                  tabs: [
                    Tab(
                      child:Text("Scheduled",
                      style: GoogleFonts.montserrat(fontSize: 15.0, color:Color.fromRGBO(31, 31, 31, 1.0)  )),
                    ),
               
                    Tab(
                      child: Text("Urgent",
                      style: GoogleFonts.montserrat(fontSize: 15.0,  color:Color.fromRGBO(31, 31, 31, 1.0) )),
                     ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      LensmanList(), LensmanList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
    )
        ],
      ),
    ClientProfile(),
    NotificationTab(),
    SearchTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     return StreamProvider<List<Lensman>>.value(
      value: DatabaseService().lensman,
      initialData: List(),
    child: Scaffold(
      bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: FontAwesomeIcons.home),
            TabItem(icon: FontAwesomeIcons.userCircle),
            TabItem(icon: Icons.notifications),
            TabItem(icon: FontAwesomeIcons.search),
          ],
          initialActiveIndex: _selectedIndex,
          onTap: _onItemTapped,
          
          activeColor: Color.fromRGBO(31, 31, 31, 1.0),
          backgroundColor: Color.fromRGBO(216, 181, 58, 1.0)
          ),

      
      
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      

    ),
    );
  }
}
