import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:picyou/services/database.dart';
import 'package:picyou/screens/home/request/request_list.dart';
import 'package:picyou/model/booking.dart';

class RequestDisp extends StatefulWidget {
  @override
  _RequestDispState createState() => _RequestDispState();
}

class _RequestDispState extends State<RequestDisp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Booking>>.value(
      value: DatabaseService().booking,
      initialData: List(),
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 8),
          child: RequestList(),
        ),
      ),
    );
  }
}
