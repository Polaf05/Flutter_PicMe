import "package:cloud_firestore/cloud_firestore.dart";
import 'package:nanoid/async.dart';
import 'package:picyou/model/lensmen.dart';
import 'package:picyou/model/booking.dart';
import 'package:picyou/model/user.dart';
import 'package:picyou/services/auth.dart';
import 'package:picyou/model/review.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final AuthService _auth = AuthService();
  final _storage = FirebaseStorage.instance;

  //default image

  String picture =
      "https://firebasestorage.googleapis.com/v0/b/picme-4c5ea.appspot.com/o/Assets%2Fdefault%20dp%2F360_F_410437733_hdq4Q3QOH9uwh0mcqAhRFzOKfrCR24Ta.jpg?alt=media&token=b1ae5147-b094-4e53-b7ac-518a6f4c218c";

  //collection reference
  final CollectionReference lensmenCollection =
      FirebaseFirestore.instance.collection('lensmen');
  final CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection('Booking');
  final CollectionReference clientCollection =
      FirebaseFirestore.instance.collection('Clients');
  final CollectionReference ratingCollection =
      FirebaseFirestore.instance.collection('Ratings');

  Future updateUserData(
    String username,
    String name,
    String address,
    String contact,
    String email,
    dynamic gallery,
    String displayPicture,
    String role,
    String coverPicture,
    bool urgent,
    int ratings,
  ) async {
    return await lensmenCollection.doc(uid).set({
      'username': username,
      'name': name,
      'address': address,
      'contact': contact,
      'email': email,
      'gallery': [
        picture,
        picture,
        picture,
        picture,
        picture,
        picture,
        picture,
        picture,
        picture
      ],
      'displayPicture': picture,
      'role': role,
      'coverPhoto':
          "https://firebasestorage.googleapis.com/v0/b/picme-4c5ea.appspot.com/o/Assets%2Fdefault%20cover%2Fdefault_cover.jpg?alt=media&token=9e6c8eb3-e5b0-4cfc-a24a-3e4619c885b3",
      'urgent': false,
      'ratings': 0,
    });
  }

  //fetch specific lensman
  Future fetchUserData(String id) async {
    dynamic result = await lensmenCollection.doc(id).get();
    DocumentSnapshot snapshot = result;
    return _specificlensman(snapshot);
  }

  Future fetchClientData(String id) async {
    dynamic result = await clientCollection.doc(id).get();
    DocumentSnapshot snapshot = result;
    return _userDetails(snapshot);
  }

  Future fetchBookingData(String id) async {
    dynamic result = await bookingCollection.doc(id).get();
    DocumentSnapshot snapshot = result;
    return _specificbooking(snapshot);
  }

  Client _userDetails(DocumentSnapshot snapshot) {
    return Client(
        name: snapshot.data()['name'] ?? '',
        email: snapshot.data()['email'] ?? '',
        role: snapshot.data()['role'] ?? '',
        contact: snapshot.data()['contact'] ?? '',
        address: snapshot.data()['address'] ?? '',
        display: snapshot.data()['displayPicture'] ?? '',
        bio: snapshot.data()['bio'] ?? '',
        cover: snapshot.data()['coverPicture'] ?? '',
        id: snapshot.id);
  }

  Lensmen _specificlensman(DocumentSnapshot snapshot) {
    return Lensmen(
        username: snapshot.data()['username'] ?? '',
        name: snapshot.data()['name'] ?? '',
        address: snapshot.data()['address'] ?? '',
        email: snapshot.data()['email'] ?? '',
        contact: snapshot.data()['contact'] ?? '',
        displayPicture: snapshot.data()['displayPicture'] ?? '',
        gallery: snapshot.data()['gallery'] ?? '',
        coverPhoto: snapshot.data()['coverPhoto'] ?? '',
        urgent: snapshot.data()['urgent'] ?? '',
        ratings: snapshot.data()['ratings'] ?? '');
  }

  Booking _specificbooking(DocumentSnapshot snapshot) {
    return Booking(
        clientName: snapshot.data()['client_name'] ?? '',
        clientEmail: snapshot.data()['client_email'] ?? '',
        clientContact: snapshot.data()['client_contact'] ?? '',
        lensmanEmail: snapshot.data()['lensman_email'] ?? '',
        lensmanName: snapshot.data()['lensman_name'] ?? '',
        clientId: snapshot.data()['client_id'] ?? '',
        lensmanId: snapshot.data()['lensman_id'] ?? '',
        status: snapshot.data()['status'] ?? '',
        request: snapshot.data()['request'] ?? '',
        date: snapshot.data()['date'] ?? '',
        id: snapshot.id ?? '');
  }

  List<Lensmen> _lensmanListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Lensmen(
        username: doc.data()['username'] ?? '',
        name: doc.data()['name'] ?? '',
        address: doc.data()['address'] ?? '',
        email: doc.data()['email'] ?? '',
        contact: doc.data()['contact'] ?? '',
        displayPicture: doc.data()['displayPicture'] ?? '',
        coverPhoto: doc.data()['coverPhoto'] ?? '',
        gallery: doc.data()['gallery'] ?? '',
        role: doc.data()['role'] ?? '',
        urgent: doc.data()['urgent'] ?? '',
        ratings: doc.data()['ratings'] ?? '',
      );
    }).toList();
  }

  List<Booking> _bookingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Booking(
          clientName: doc.data()['client_name'] ?? '',
          clientEmail: doc.data()['client_email'] ?? '',
          clientContact: doc.data()['client_contact'] ?? '',
          lensmanEmail: doc.data()['lensman_email'] ?? '',
          lensmanName: doc.data()['lensman_name'] ?? '',
          clientId: doc.data()['client_id'] ?? '',
          lensmanId: doc.data()['lensman_id'] ?? '',
          status: doc.data()['status'] ?? '',
          request: doc.data()['request'] ?? '',
          date: doc.data()['date'] ?? '',
          id: doc.id ?? '');
    }).toList();
  }

  List<Reviews> _ratingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Reviews(
        clientId: doc.data()["client_id"] ?? '',
        lensmanId: doc.data()["lensman_id"] ?? '',
        rating: doc.data()["rating"] ?? '',
        review: doc.data()["comment"] ?? '',
      );
    }).toList();
  }

  //get stream
  Stream<List<Lensmen>> get lensmen {
    return lensmenCollection.snapshots().map(_lensmanListFromSnapshot);
  }

  Stream<List<Booking>> get booking {
    dynamic uid = AuthService().getCurrentUser();
    return bookingCollection
        .where('lensman_id', isEqualTo: uid.uid)
        .snapshots()
        .map(_bookingListFromSnapshot);
  }

  Stream<List<Reviews>> get review {
    dynamic uid = AuthService().getCurrentUser();
    return ratingCollection
        .where('lensman_id', isEqualTo: uid.uid)
        .snapshots()
        .map(_ratingListFromSnapshot);
  }

  // update profile
  Future updateData(
    String username,
    String name,
    String address,
    String contact,
    String email,
    dynamic gallery,
    String displayPicture,
    String coverPhoto,
    bool urgent,
    int ratings,
  ) async {
    dynamic id = _auth.getCurrentUser();
    return await lensmenCollection.doc(id.uid).set({
      'username': username,
      'name': name,
      'address': address,
      'contact': contact,
      'email': email,
      'gallery': gallery,
      'displayPicture': displayPicture,
      'coverPhoto': coverPhoto,
      'urgent': urgent,
      'ratings': ratings,
    });
  }

  //upload image
  Future uploadImageToFirebase(String email, dynamic file) async {
    String id = await nanoid();

    dynamic snapshot =
        await _storage.ref().child('Lensman/$email/' + id).putFile(file);

    String url = await snapshot.ref.getDownloadURL();
    return url;
  }

//Update GAllery
  Future updateGallery(int loc, String id, dynamic gallery) async {
    await lensmenCollection.doc(id).update({
      'gallery': gallery,
    });
  }

//Update booking Status
  Future updateStatus(String id, String status) async {
    await bookingCollection.doc(id).update({'status': status});
  }
}
