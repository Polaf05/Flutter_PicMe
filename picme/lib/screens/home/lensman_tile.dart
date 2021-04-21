import 'package:flutter/material.dart';
import 'package:picme/models/lensman.dart';

class LensmanTile extends StatelessWidget {
  final Lensman lens;
  LensmanTile({this.lens});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(lens.display),
          ),
          title: Text(lens.name),
          subtitle: Text(lens.email),
        ),
      ),
    );
  }
}
