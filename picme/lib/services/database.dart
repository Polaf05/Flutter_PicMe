import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:picme/models/booking.dart';
import 'package:picme/models/lensman.dart';
import 'package:picme/models/user.dart';
import 'package:nanoid/nanoid.dart';
import 'package:get/get.dart';
import 'package:picme/services/auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final _storage = FirebaseStorage.instance;

  // collection references

  final CollectionReference clientCollection =
      FirebaseFirestore.instance.collection('Clients');

  final CollectionReference employeeCollection =
      FirebaseFirestore.instance.collection('lensmen');

  final CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection('Booking');

  final CollectionReference ratingCollection =
      FirebaseFirestore.instance.collection('Ratings');

  //Create

  Future updateUserData(String email, String name, String role) async {
    return await clientCollection.doc(uid).set({
      'email': email,
      'name': name,
      'contact': "Contact unavailable",
      'address': "Address unavailable",
      'bio': "Bio unavailable",
      'role': role,
      'coverPicture':
          "https://firebasestorage.googleapis.com/v0/b/picme-4c5ea.appspot.com/o/Assets%2Fdefault%20cover%2Fpb.png?alt=media&token=62a61f29-5f5e-4ee8-bcd9-5c08dbd9091b",
      'displayPicture':
          'https://firebasestorage.googleapis.com/v0/b/picme-4c5ea.appspot.com/o/Assets%2Fdefault%20dp%2F360_F_410437733_hdq4Q3QOH9uwh0mcqAhRFzOKfrCR24Ta.jpg?alt=media&token=b1ae5147-b094-4e53-b7ac-518a6f4c218c',
    });
  }

  //Fetch Specific Data

  Future fetchUserData(String id) async {
    dynamic result = await employeeCollection.doc(id).get();
    DocumentSnapshot snapshot = result;
    return _specificlensman(snapshot);
  }

  Future fetchClientData(String id) async {
    dynamic result = await clientCollection.doc(id).get();
    DocumentSnapshot snapshot = result;
    return _userDetails(snapshot);
  }

  //Object Model

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

  Lensman _specificlensman(DocumentSnapshot snapshot) {
    return Lensman(
        name: snapshot.data()['name'] ?? '',
        email: snapshot.data()['email'] ?? '',
        contact: snapshot.data()['contact'] ?? '',
        display: snapshot.data()['displayPicture'] ?? '',
        gallery: snapshot.data()['gallery'] ?? '',
        id: snapshot.id);
  }

  //Get Lensman

  Lensman searchLensman(DocumentSnapshot snapshot) {
    return Lensman(
        name: snapshot.data()['name'] ?? '',
        email: snapshot.data()['email'] ?? '',
        contact: snapshot.data()['contact'] ?? '',
        display: snapshot.data()['displayPicture'] ?? '',
        gallery: snapshot.data()['gallery'] ?? '',
        id: snapshot.id);
  }

  //Lensman list from snapshot
  List<Lensman> _lensmanListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Lensman(
          name: doc.data()['name'] ?? '',
          email: doc.data()['email'] ?? '',
          contact: doc.data()['contact'] ?? '',
          display: doc.data()['displayPicture'] ?? '',
          address: doc.data()['address'] ?? '',
          username: doc.data()['username'] ?? '',
          gallery: doc.data()['gallery'] ?? '',
          id: doc.id);
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

  //Check user role

  Future checkUser(String email, String password) async {
    bool find = false;
    dynamic result =
        await clientCollection.where("email", isEqualTo: email).get();
    QuerySnapshot snapshot = result;

    snapshot.docs.forEach((element) {
      if (element.data()['email'] == email) {
        find = true;
      }
    });

    return find;
  }

  //Save updated Credentials

  Future updateUserInformation(String id, String cover, String display,
      String name, String address, String contact, String bio) async {
    await clientCollection.doc(id).update({
      'coverPicture': cover,
      'displayPicture': display,
      'name': name,
      'address': address,
      'contact': contact,
      'bio': bio,
    });
  }

  //Booking

  Future bookLensman(
      String client_id,
      String lensman_id,
      String clientName,
      String clientEmail,
      String clientContact,
      String request,
      String lensmanName,
      String lensmanEmail,
      DateTime date) async {
    DocumentReference result = await bookingCollection.add({
      'lensman_id': lensman_id,
      'client_id': client_id,
      'client_name': clientName,
      'client_email': clientEmail,
      'client_contact': clientContact,
      'lensman_name': lensmanName,
      'lensman_email': lensmanEmail,
      'request': request,
      'date': date,
      'status': 'Pending',
    });

    return result;
  }

  //Ratings

  Future rateLensman(String clientId, String lensmanId, String comment,
      int rate, String id) async {
    await ratingCollection.doc(id).set({
      'lensman_id': lensmanId,
      'client_id': clientId,
      'request': comment,
      'rating': rate,
    });

    await bookingCollection.doc(id).update({
      'status': 'Done',
    });
  }

  //get client streams

  Stream<List<Lensman>> get lensman {
    return employeeCollection.snapshots().map(_lensmanListFromSnapshot);
  }

  Stream<List<Booking>> get booking {
    dynamic uid = AuthService().getCurrentUser();

    return bookingCollection
        .where('client_id', isEqualTo: uid.uid)
        .snapshots()
        .map(_bookingListFromSnapshot);
  }

  //Upload Image
  Future uploadImageToFirebase(String email, dynamic file) async {
    String id = nanoid();

    dynamic snapshot = await _storage.ref().child('Client/' + id).putFile(file);

    String url = await snapshot.ref.getDownloadURL();
    return url;
  }
}

class DataController extends GetxController {
  final CollectionReference employeeCollection =
      FirebaseFirestore.instance.collection('lensmen');

  Future getData(String collection) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection(collection).get();

    return snapshot.docs;
  }

  Future queryData(String queryString) async {
    return employeeCollection
        .where('name', isGreaterThanOrEqualTo: queryString)
        .where('name', isLessThan: queryString + 'z')
        .get();
  }
}
