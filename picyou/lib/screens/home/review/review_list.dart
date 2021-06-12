import 'package:flutter/material.dart';
import 'package:picyou/model/booking.dart';
import 'package:picyou/model/review.dart';
import 'package:provider/provider.dart';
import 'package:picyou/screens/home/review/review_tile.dart';

class ReviewList extends StatefulWidget {
  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    final review = Provider.of<List<Reviews>>(context);
    print(review.length);
    return ListView.builder(
      itemCount: review.length,
      itemBuilder: (context, index) {
        return ReviewTile(reviews: review[index]);
      },
    );
  }
}
