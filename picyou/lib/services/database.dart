import "package:cloud_firestore/cloud_firestore.dart";
import 'package:picyou/model/lensmen.dart';
import 'package:picyou/model/booking.dart';
import 'package:picyou/model/user.dart';
import 'package:picyou/services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final AuthService _auth = AuthService();
  final _storage = FirebaseStorage.instance;

  //collection reference
  final CollectionReference lensmenCollection =
      FirebaseFirestore.instance.collection('lensmen');
  final CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection('Booking');
  final CollectionReference clientCollection =
      FirebaseFirestore.instance.collection('Clients');

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
  ) async {
    return await lensmenCollection.doc(uid).set({
      'username': username,
      'name': name,
      'address': address,
      'contact': contact,
      'email': email,
      'gallery': [],
      'displayPicture': displayPicture,
      'role': role,
      'coverPicture': coverPicture,
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
        username: snapshot.data()['username'],
        name: snapshot.data()['name'],
        address: snapshot.data()['address'],
        email: snapshot.data()['email'],
        contact: snapshot.data()['contact'],
        displayPicture: snapshot.data()['displayPicture'],
        gallery: snapshot.data()['gallery'],
        coverPicture: snapshot.data()['coverPicture'] ?? '');
  }

  //lensmen data
  List<Lensmen> _lensmanListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Lensmen(
        username: doc.data()['username'] ?? '',
        name: doc.data()['name'] ?? '',
        address: doc.data()['address'] ?? '',
        email: doc.data()['email'] ?? '',
        contact: doc.data()['contact'] ?? '',
        displayPicture: doc.data()['displayPicture'] ?? '',
        gallery: doc.data()['gallery'] ?? '',
        role: doc.data()['role'] ?? '',
      );
    }).toList();
  }

  //get stream
  Stream<List<Lensmen>> get lensmen {
    return lensmenCollection.snapshots().map(_lensmanListFromSnapshot);
  }

  //lensmen data
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

  //get stream
  Stream<List<Booking>> get booking {
    dynamic uid = AuthService().getCurrentUser();
    return bookingCollection
        .where('lensman_email', isEqualTo: 'reniel262@gmail.vcom')
        .snapshots()
        .map(_bookingListFromSnapshot);
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
    });
  }

  //upload image
  Future uploadImageToFirebase(String email, dynamic file) async {
    dynamic id = _auth.getCurrentUser();

    print("working");
    dynamic snapshot = await _storage
        .ref()
        .child('Lensman/' + email + '/' + 'dp')
        .putFile(file);

    print("work");

    String url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
