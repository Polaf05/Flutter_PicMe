import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:picme/models/lensman.dart';
import 'package:picme/models/user.dart';
import 'package:nanoid/nanoid.dart';
import 'package:get/get.dart';

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

  Future bookLensman(String client_id, String lensman_id, String name,
      String email, String contact, String request, DateTime date) async {
    DocumentReference result = await bookingCollection.add({
      'lensman_id': lensman_id,
      'client_id': client_id,
      'name': name,
      'email': email,
      'contact': contact,
      'request': request,
      'date': date,
      'status': 'pending',
    });

    return result;
  }

  //get client streams

  Stream<List<Lensman>> get lensman {
    return employeeCollection.snapshots().map(_lensmanListFromSnapshot);
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
