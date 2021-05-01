import 'package:flutter/material.dart';
import 'package:picme/screens/home/home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/services/database.dart';

class Book extends StatefulWidget {
  final String id;

  Book({this.id});

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  final DatabaseService _db = DatabaseService();
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  DateTime _date = DateTime.now();
  TextEditingController _datecontroller = new TextEditingController();

  final myFormat = new DateFormat('d-MM-yyyy');

  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1947),
      lastDate: DateTime(2030),
    );

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker ?? _date;
        date = _date;
      });
    }
  }

  //Text field State

  String name = "";
  String email = "";
  String contact = "";
  String message = "";
  DateTime date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Home()));
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
            size: 32,
          ),
        ),
        title: Text(
          " ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/bg.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 1200,
            ),
          ),
          Container(
            height: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double innerWidth = constraints.maxWidth;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 100,
                      bottom: 90,
                      left: 15,
                      right: 15,
                      child: Container(
                        height: 10,
                        width: innerWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                        child: Center(
                          child: Form(
                            key: _formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    'Request Form',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Verdana',
                                        color: Color.fromRGBO(31, 31, 31, 1.0)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter your Name' : null,
                                    onChanged: (val) {
                                      setState(() => name = val);
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: 'Fullname',
                                      labelText: 'Name',
                                      prefixIcon: const Icon(
                                        Icons.person_add_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter your Email' : null,
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: 'Enter Email',
                                      labelText: 'Email',
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    validator: (val) => val.length != 11
                                        ? 'Contact Number must be 11 digit'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => contact = val);
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: 'Enter Contact',
                                      labelText: 'Contact Number',
                                      prefixIcon: const Icon(
                                        Icons.call_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    validator: (val) => val.isEmpty
                                        ? 'Please input the service you need'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => message = val);
                                    },
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              width: 5.0,
                                              color: Color.fromRGBO(
                                                  216, 181, 58, 1.0))),
                                      hintText: 'Request',
                                      labelText: 'Whats your request?',
                                      prefixIcon: const Icon(
                                        Icons.person_add_outlined,
                                        color:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: TextFormField(
                                        validator: (val) => date == null
                                            ? 'Input booking date'
                                            : null,
                                        cursorColor:
                                            Color.fromRGBO(216, 181, 58, 1.0),
                                        readOnly: true,
                                        onTap: () {
                                          setState(() {
                                            _selectDate(context);
                                          });
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      216, 181, 58, 1.0))),
                                          hintText:
                                              ('${myFormat.format(_date)}'),
                                          labelText: 'Date',
                                          prefixIcon: const Icon(
                                            Icons.calendar_today_outlined,
                                            color: Color.fromRGBO(
                                                216, 181, 58, 1.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 10, 30, 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0)),
                                      color: Color.fromRGBO(237, 237, 237, 1.0),
                                      onPressed: () {},
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(31, 31, 31, 1.0),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      padding:
                                          EdgeInsets.fromLTRB(35, 10, 35, 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0)),
                                      color: Color.fromRGBO(31, 31, 31, 1.0),
                                      onPressed: () async {
                                        if (_formkey.currentState.validate()) {
                                          dynamic id = _auth.getCurrentUser();
                                          dynamic result = _db.bookLensman(
                                              id.uid,
                                              widget.id,
                                              name,
                                              email,
                                              contact,
                                              message,
                                              date);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Home()));
                                        }
                                      },
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
