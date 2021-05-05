
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:picyou/model/lensmen.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference lensmenCollection =
      FirebaseFirestore.instance.collection('lensmen');

  Future updateUserData(
      String username,
      String name,
      String address,
      String contact,
      String email,
      dynamic gallery,      String displayPicture,
      String role,) async {
    return await lensmenCollection.doc(uid).set({
      'username' : username,
      'name' : name,
      'address' : address,
      'contact' : contact,
      'email' : email,
      'gallery' : [],
      'displayPicture': displayPicture,
      'role': role,
    });
  }

  //fetch specific lensman
   Future fetchUserData(String id) async {
    dynamic result = await lensmenCollection.doc(id).get();
    DocumentSnapshot snapshot = result;
    return _specificlensman(snapshot);
  }

  Lensmen _specificlensman(DocumentSnapshot snapshot) {
    return Lensmen(
        username: snapshot.data()['username'],
        name: snapshot.data()['name'],
        address: snapshot.data()['address'],
        email: snapshot.data()['email'],
        contact: snapshot.data()['contact'],
        displayPicture: snapshot.data()['display'],
        gallery: snapshot.data()['gallery'] ?? '');
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
 
}
