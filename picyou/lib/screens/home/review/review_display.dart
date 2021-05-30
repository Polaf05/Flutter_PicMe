import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:picyou/services/database.dart';
import 'package:picyou/screens/home/review/review_list.dart';
import 'package:picyou/model/review.dart';

class ReviewDisp extends StatefulWidget {
  @override
  _ReviewDispState createState() => _ReviewDispState();
}

class _ReviewDispState extends State<ReviewDisp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Reviews>>.value(
      value: DatabaseService().review,
      initialData: List(),
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 68),
          child: ReviewList(),
        ),
      ),
    );
  }
}
