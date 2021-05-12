import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picme/main.dart';
import 'package:picme/models/lensman.dart';
import 'package:picme/screens/home/lensman_tile.dart';
import 'package:picme/screens/home/search_data.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/services/database.dart';
import 'package:provider/provider.dart';
import 'package:picme/screens/home/lensman_list.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseService _db = DatabaseService();
  QuerySnapshot snapshotData;
  bool isExecuted = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            isExecuted = false;
            searchController.text = "";
          });
        },
      ),
      appBar: AppBar(
          actions: [
            GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      val.queryData(searchController.text).then((value) {
                        snapshotData = value;
                        setState(() {
                          isExecuted = true;
                        });
                      });
                    });
              },
            )
          ],
          title: TextField(
            style: TextStyle(color: Colors.yellow),
            decoration: InputDecoration(
                hintText: 'Search Lensman',
                hintStyle: TextStyle(color: Colors.yellow)),
            controller: searchController,
          )),
      body: isExecuted
          ? SearchData(snapshotData: snapshotData)
          : Container(
              child: Center(
                child: Text(
                  "Search Lensman",
                  style: TextStyle(color: Colors.yellow, fontSize: 30.0),
                ),
              ),
            ),
    );
  }
}
