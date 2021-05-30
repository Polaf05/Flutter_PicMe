import 'package:flutter/material.dart';
import 'package:picyou/model/booking.dart';
import 'package:provider/provider.dart';
import 'package:picyou/screens/home/request/request_tile.dart';

class RequestList extends StatefulWidget {
  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  @override
  Widget build(BuildContext context) {
    final book = Provider.of<List<Booking>>(context);
    return ListView.builder(
      itemCount: book.length,
      itemBuilder: (context, index) {
        return RequestTile(booking: book[index]);
      },
    );
  }
}
