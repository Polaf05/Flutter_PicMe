import 'package:flutter/material.dart';
import 'package:picme/screens/home/rate_tile.dart';
import 'package:provider/provider.dart';
import 'package:picme/models/booking.dart';

class RateTile extends StatefulWidget {
  @override
  _RateTileState createState() => _RateTileState();
}

class _RateTileState extends State<RateTile> {
  @override
  Widget build(BuildContext context) {
    final book = Provider.of<List<Booking>>(context);

    return ListView.builder(
      itemCount: book.length,
      itemBuilder: (context, index) {
        return RatingTile(booking: book[index]);
      },
    );
  }
}
