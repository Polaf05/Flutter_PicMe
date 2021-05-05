import 'package:flutter/material.dart';
import 'package:picyou/model/lensmen.dart';
import 'package:provider/provider.dart';
import 'package:picyou/screens/home/lensmen_tile.dart';

class LensmenList extends StatefulWidget {
  @override
  _LensmenListState createState() => _LensmenListState();
}

class _LensmenListState extends State<LensmenList> {
  @override
  Widget build(BuildContext context) {
    final lensmen = Provider.of<List<Lensmen>>(context);

    return ListView.builder(
      itemCount: lensmen.length,
      itemBuilder: (context, index) {
        return LensmenTile(lens: lensmen[index]);
      },
    );
  }
}
