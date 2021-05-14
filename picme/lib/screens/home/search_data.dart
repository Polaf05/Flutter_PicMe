import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:picme/models/lensman.dart';
import 'package:picme/screens/home/search_tile.dart';
import 'package:provider/provider.dart';
import 'package:picme/screens/home/lensman_tile.dart';

class SearchData extends StatefulWidget {
  final QuerySnapshot snapshotData;

  SearchData({this.snapshotData});
  @override
  _SearchDataState createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return SearchTile(lens: widget.snapshotData.docs[index]);
        });
  }
}
