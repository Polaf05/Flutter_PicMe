import 'package:flutter/material.dart';
import 'package:picme/models/booking.dart';
import 'package:picme/screens/home/reviews/comment_tile.dart';
import 'package:provider/provider.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/services/database.dart';

class CommentList extends StatefulWidget {
  final String uid;

  CommentList({this.uid});
  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  AuthService _auth = AuthService();
  DatabaseService _db = DatabaseService();

  dynamic info = [];

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dynamic fetch = await _db.reviews(widget.uid);
      setState(() {
        info = fetch;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: info.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CommentTile(reviews: info[index]);
        });
  }
}
