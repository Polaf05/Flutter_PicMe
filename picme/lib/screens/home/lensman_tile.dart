import 'package:flutter/material.dart';
import 'package:picme/models/lensman.dart';
import 'package:picme/screens/home/show_details.dart';

class LensmanTile extends StatelessWidget {
  final Lensman lens;
  LensmanTile({this.lens});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Card(
            color: Color.fromRGBO(21, 21, 21, 21),
            margin: new EdgeInsets.fromLTRB(20, 0, 20, 0),
            elevation: 5.0,
            child: Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(43, 43, 43, 1.0)),
                child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                    leading: Container(
                      padding: EdgeInsets.only(right: 22.0),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: 4.0,
                                  color: Color.fromRGBO(216, 181, 58, 1.0)))),
                      child: Image.network(
                        lens.display,
                        height: 420,
                        width: 80,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    title: Text(
                      lens.name,
                      style: TextStyle(
                          color: Color.fromRGBO(237, 237, 237, 1.0),
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(Icons.email_outlined,
                            color: Color.fromRGBO(216, 181, 58, 1.0)),
                        Text(lens.email,
                            style: TextStyle(
                                color: Color.fromRGBO(237, 237, 237, 1.0)))
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Color.fromRGBO(216, 181, 58, 1.0), size: 30.0),
                    onTap: () async {
                      // dynamic result = await DatabaseService().fetchUserData(lens.id);
                      // print(result.name);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShowDetails(lens: lens)));
                    })),
          ),
        ));
  }
}
