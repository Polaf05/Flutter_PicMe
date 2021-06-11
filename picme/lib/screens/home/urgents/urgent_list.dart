import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picme/models/lensman.dart';
import 'package:provider/provider.dart';
import 'package:picme/screens/home/lensman_tile.dart';

class UrgentList extends StatefulWidget {
  @override
  _UrgentListState createState() => _UrgentListState();
}

class _UrgentListState extends State<UrgentList> {
  @override
  Widget build(BuildContext context) {
    final lensman = Provider.of<List<Lensman>>(context);

    return ListView.builder(
      itemCount: lensman.length,
      itemBuilder: (context, index) {
        return LensmanTile(lens: lensman[index]);
      },
    );
  }
}
