import 'package:flutter/material.dart';
import 'package:picme/models/lensman.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/services/database.dart';
import 'package:provider/provider.dart';
import 'package:picme/screens/home/lensman_list.dart';
import 'package:carousel_pro/carousel_pro.dart';


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
    return StreamProvider<List<Lensman>>.value(
      value: DatabaseService().lensman,
      initialData: List(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard',
           style: TextStyle(color: Color.fromRGBO(216,181,58,1.0), fontSize: 30.0, fontFamily:'Poppins',fontWeight: FontWeight.bold),),
          backgroundColor:  Color.fromRGBO(31,31,31,1.0),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person,
              color: Color.fromRGBO(216,181,58,1.0),),
              label: Text('Logout',
              style: TextStyle(color:Color.fromRGBO(247,247,232,1.0),),
              ),
              onPressed: () async {
                await _auth.signOutUser();
              },
            )
          ],
        ),
        body: NestedScrollView(
          controller: ScrollController(),
          physics: ClampingScrollPhysics(),
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                pinned: true,
                backgroundColor:  Color.fromRGBO(31,31,31,1.0),
                flexibleSpace: FlexibleSpaceBar(
                  background:

                      /// _buildCarousel() in your case....
            Container(
                height: 200.0,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 70),
               
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,  
                    height: 170.0,  
                    
                    child: Carousel(
                      dotSize: 4.0,
                      dotBgColor: Colors.transparent,
                      dotColor: Color.fromRGBO(204,154,72,1.0),
                      indicatorBgPadding: 5.0,
                      dotSpacing: 15.0,
                      dotVerticalPadding: 5.0,
                    

                      images:[
                        InkWell(
                          onTap: (){},
                          child: Image.asset(
                            'assets/nct.jpg', 
                            fit: BoxFit.cover,
                            
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Image.asset(
                            'assets/en.jpg', 
                            fit: BoxFit.cover,
                            
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Image.asset(
                            'assets/bts.jpg', 
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),

                  ),
                ],
              ),
           )
            ),
                expandedHeight: 250.0,

                /// your Carousel + Tabbar height(50)
                
                floating: true,
                bottom: TabBar(
                  indicatorPadding: EdgeInsets.fromLTRB(20,0,20,0),
                  unselectedLabelColor:Color.fromRGBO(237,237,237,1.0),
                  indicator: BoxDecoration(
                    color: Color.fromRGBO(43,43,43,1.0),
                    border: Border(
                    top:  BorderSide(width: 4.0, color: Color.fromRGBO(216,181,58,1.0)),
                    )
                  ),
                  labelColor: Color.fromRGBO(216,181,58,1.0),
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: tb,
                  tabs: <Widget>[
                    Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Scheduled",
                      style: TextStyle(fontFamily: "BarlowBold", fontSize: 15.0)),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Urgent",
                      style: TextStyle(fontFamily: "BarlowBold", fontSize: 15.0)),
                      
                    ),
                  ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: tb,
            children: <Widget>[LensmanList(), LensmanList()],
          ),
        ),
        backgroundColor:  Color.fromRGBO(31,31,31,1.0),
      ),
    );
  }
}
