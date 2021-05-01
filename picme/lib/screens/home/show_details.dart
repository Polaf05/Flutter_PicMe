import 'package:flutter/material.dart';
import 'package:picme/screens/home/book.dart';
import 'package:picme/models/lensman.dart';

class ShowDetails extends StatefulWidget {
  final Lensman lens;

  ShowDetails({this.lens});

  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  @override
  Widget build(BuildContext context) {
    //  Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                      top: 230,
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
                      margin: EdgeInsets.fromLTRB(50, 310, 50, 0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            widget.lens.name,
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
                            widget.lens.email,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)),
                                color: Color.fromRGBO(216, 181, 58, 1.0),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          Book(id: widget.lens.id)));
                                },
                                child: Text(
                                  'Accept',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              FlatButton(
                                padding: EdgeInsets.fromLTRB(15, 10, 20, 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)),
                                color: Color.fromRGBO(237, 237, 237, 1.0),
                                onPressed: () {},
                                child: Text(
                                  'Reject',
                                  style: TextStyle(
                                    color: Color.fromRGBO(31, 31, 31, 1.0),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 170,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: 130.0,
                            width: 120.0,
                            child: Image(
                              image: NetworkImage(widget.lens.display),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 420.0,
                        bottom: 0,
                      ),
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: widget.lens.gallery.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(widget.lens.gallery[index]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }),
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
