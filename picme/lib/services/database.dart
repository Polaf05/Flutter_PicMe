import "package:cloud_firestore/cloud_firestore.dart";
import 'package:picme/models/lensman.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection references

  final CollectionReference clientCollection =
      FirebaseFirestore.instance.collection('Clients');

  final CollectionReference employeeCollection =
      FirebaseFirestore.instance.collection('Photographer');

  //Create

  Future updateUserData(String email, String name, String role) async {
    return await clientCollection.doc(uid).set({
      'email': email,
      'name': name,
      'role': role,
    });
  }

  //Fetch Specific Data

  Future fetchUserData(String id) async {
    dynamic result = await employeeCollection.doc(id).get();
    DocumentSnapshot snapshot = result;
    return _specificlensman(snapshot);
  }

  Lensman _specificlensman(DocumentSnapshot snapshot) {
    return Lensman(
        name: snapshot['name'],
        email: snapshot['email'],
        contact: snapshot['contact'],
        display: snapshot['display']);
  }

  //Lensman list from snapshot
  List<Lensman> _lensmanListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Lensman(
          name: doc.data()['name'] ?? '',
          email: doc.data()['email'] ?? '',
          contact: doc.data()['contact'] ?? '',
          display: doc.data()['display'] ?? '',
          id: doc.id);
    }).toList();
  }

  //get client streams

  Stream<List<Lensman>> get lensman {
    return employeeCollection.snapshots().map(_lensmanListFromSnapshot);
  }
}
