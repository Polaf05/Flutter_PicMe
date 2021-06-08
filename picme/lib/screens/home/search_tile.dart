import 'package:flutter/material.dart';
import 'package:picme/models/lensman.dart';
import 'package:picme/screens/home/show_details.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTile extends StatelessWidget {
  final Lensman lens;
  SearchTile({this.lens});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 180,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ShowDetails(
                    lens: lens,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(lens.display),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lens.name,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 7),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: Color.fromRGBO(216, 181, 58, 1.0),
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                lens.email,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color.fromRGBO(216, 181, 58, 1.0),
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                lens.address,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.call,
                              color: Color.fromRGBO(216, 181, 58, 1.0),
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                lens.contact,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: RatingBarIndicator(
                            rating: lens.rating.toDouble(),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    // return Container(
    //     height: 150.0,
    //     child: Padding(
    //       padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
    //       child: Card(
    //         color: Color.fromRGBO(21, 21, 21, 21),
    //         margin: new EdgeInsets.fromLTRB(20, 0, 20, 0),
    //         elevation: 5.0,
    //         child: Container(
    //             decoration:
    //                 BoxDecoration(color: Color.fromRGBO(43, 43, 43, 1.0)),
    //             child: ListTile(
    //                 contentPadding: EdgeInsets.fromLTRB(20, 30, 20, 30),
    //                 leading: Container(
    //                   padding: EdgeInsets.only(right: 22.0),
    //                   decoration: BoxDecoration(
    //                       border: Border(
    //                           right: BorderSide(
    //                               width: 4.0,
    //                               color: Color.fromRGBO(216, 181, 58, 1.0)))),
    //                   child: Image.network(
    //                     lens.display,
    //                     height: 420,
    //                     width: 80,
    //                     fit: BoxFit.fitWidth,
    //                   ),
    //                 ),
    //                 title: Text(
    //                   lens.name,
    //                   style: TextStyle(
    //                       color: Color.fromRGBO(237, 237, 237, 1.0),
    //                       fontSize: 25.0,
    //                       fontWeight: FontWeight.bold),
    //                 ),
    //                 subtitle: Row(
    //                   children: <Widget>[
    //                     Icon(Icons.email_outlined,
    //                         color: Color.fromRGBO(216, 181, 58, 1.0)),
    //                     Text(lens.email,
    //                         style: TextStyle(
    //                             color: Color.fromRGBO(237, 237, 237, 1.0)))
    //                   ],
    //                 ),
    //                 trailing: Icon(Icons.keyboard_arrow_right,
    //                     color: Color.fromRGBO(216, 181, 58, 1.0), size: 30.0),
    //                 onTap: () async {
    //                   dynamic result = await AuthService().getCurrentUser();

    //                   dynamic user =
    //                       await DatabaseService().fetchClientData(result.uid);
    //                   // print(result.name);
    //                   Navigator.pushAndRemoveUntil(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) =>
    //                             ShowDetails(lens: lens, user: user)),
    //                     (Route<dynamic> route) => false,
    //                   );
    //                 })),
    //       ),
    //     ));
  }
}
