import 'package:flutter/material.dart';
import 'package:picme/models/lensman.dart';
import 'package:picme/models/user.dart';
import 'package:picme/screens/home/home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:picme/services/auth.dart';
import 'package:picme/services/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picme/services/email.dart';
import 'package:picme/screens/wrapper.dart';
import 'package:picme/screens/home/show_details.dart';

class Book extends StatefulWidget {
  final Lensman lens;
  final Client user;

  Book({this.lens, this.user});

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  final DatabaseService _db = DatabaseService();
  final AuthService _auth = AuthService();
  final MailerService _mail = MailerService();
  final _formkey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        name = widget.user.name;
        email = widget.user.email;
        contact = widget.user.contact;
      });
    });
  }

  DateTime _date = DateTime.now();
  TextEditingController _datecontroller = new TextEditingController();

  final myFormat = new DateFormat('d-MM-yyyy');

  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime(2030),
    );

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker ?? _date;
        date = _date;
      });
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
                    child: Column(
                      children: [
                        Text(
                          'Request Sent!!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Your request sent successfully, wait for confirmation.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: Color.fromRGBO(237, 237, 237, 1.0),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Wrapper()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text(
                            'Proceed',
                            style: TextStyle(
                              color: Color.fromRGBO(31, 31, 31, 1.0),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: -60,
                    child: CircleAvatar(
                      backgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
                      radius: 60,
                      child: Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    )),
              ],
            ));
      },
    );
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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ShowDetails(lens: widget.lens, user: widget.user)),
              (Route<dynamic> route) => false,
            );
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
              "assets/back.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 1024,
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
                          borderRadius: BorderRadius.circular(12),
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
                                    enabled: false,
                                    initialValue: widget.user.name,
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
                                    enabled: false,
                                    initialValue: widget.user.email,
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
                                    enabled: false,
                                    initialValue: widget.user.contact,
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
                                              BorderRadius.circular(8.0)),
                                      color: Color.fromRGBO(237, 237, 237, 1.0),
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Wrapper()),
                                          (Route<dynamic> route) => false,
                                        );
                                      },
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
                                          EdgeInsets.fromLTRB(45, 10, 45, 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      color: Color.fromRGBO(31, 31, 31, 1.0),
                                      onPressed: () async {
                                        if (_formkey.currentState.validate()) {
                                          dynamic result =
                                              await _db.bookLensman(
                                                  widget.user.id,
                                                  widget.lens.id,
                                                  widget.user.name,
                                                  widget.user.email,
                                                  widget.user.contact,
                                                  message,
                                                  widget.lens.name,
                                                  widget.lens.email,
                                                  date);

                                          await _mail.sendReciept(
                                              widget.user.email,
                                              widget.user.name,
                                              widget.lens.email,
                                              widget.lens.name,
                                              result.id,
                                              message,
                                              date);

                                          await _mail.sendRequest(
                                              widget.user.email,
                                              widget.user.name,
                                              widget.lens.email,
                                              widget.lens.name,
                                              result.id,
                                              message,
                                              date);

                                          _showMyDialog();
                                        }
                                      },
                                      child: Text(
                                        'Send',
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
