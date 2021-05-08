import 'package:flutter/material.dart';
import 'package:picme/models/user.dart';
import 'package:picme/screens/home/book.dart';
import 'package:picme/models/lensman.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picme/screens/home/edit.dart';



class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: null,
        body: new ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                Container(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    overflow: Overflow.visible,
                    children: <Widget>[ 
                      Row(children: <Widget>[
                        Expanded(child: 
                        Container(
                        height: 250.0,
                        decoration: BoxDecoration(                          
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/1.jpg'),
                          )
                        ),
                      ),)
                      ],
                      ),
                      Positioned(
                        top: 100.0,
                        child: Container(
                          height: 190.0,
                          width: 190.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/11.jpg'),
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 6.0
                            )
                          ),
                        ),
                      ),
                    ],)                    
                  ,
                ),


                    Container(
                      margin: EdgeInsets.only(top:60),
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Text('Monkey D. Luffy', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0
                            ),),              
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      child: Text('luffy@example.com', style: TextStyle(fontSize: 18.0),)
                    ),

                    SizedBox(height: 20.0,),
                    Container(
                      padding: EdgeInsets.only(left: 10.0,right: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Icon(Icons.home,
                                    size: 30,
                                    color: Color.fromRGBO(216, 181, 58, 1.0)),
                                Text(
                                  "Butal Events Place",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                          ],),
                          SizedBox(height: 10.0,),
                          Row(children: <Widget>[
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
                          ],),
                          SizedBox(height: 10.0,),
                          Row(children: <Widget>[
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
                            ],
                          ),

                          SizedBox(height: 20.0,),
                          Center(
                            child: Row(
                              children: <Widget>[
                                FlatButton(
                                      padding:
                                          EdgeInsets.fromLTRB(125, 10, 125, 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      color: Color.fromRGBO(216, 181, 58, 1.0),
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Edit()));
                                      },
                                    child:Text(
                                        'Edit Profile',
                                        style: GoogleFonts.poppins(
                                          color: Color.fromRGBO(31, 31, 31, 1.0),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                    ),
                            ],),
                          ),

                          Container(
                            height: 10.0,
                            child: 
                            Divider(
                              color: Colors.grey,                              
                            ),
                          ),

                       

                    ]))])]));
                          
                    
                



  }
}