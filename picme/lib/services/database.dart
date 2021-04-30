import "package:cloud_firestore/cloud_firestore.dart";
import 'package:picme/models/lensman.dart';
import 'package:picme/services/auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection references

  final CollectionReference clientCollection =
      FirebaseFirestore.instance.collection('Clients');

  final CollectionReference employeeCollection =
      FirebaseFirestore.instance.collection('Photographer');

  final CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection('Booking');

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
        display: snapshot['display'],
        gallery: snapshot.data()['gallery'] ?? '');
  }

  //Lensman list from snapshot
  List<Lensman> _lensmanListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Lensman(
          name: doc.data()['name'] ?? '',
          email: doc.data()['email'] ?? '',
          contact: doc.data()['contact'] ?? '',
          display: doc.data()['display'] ?? '',
          gallery: doc.data()['gallery'] ?? '',
          id: doc.id);
    }).toList();
  }

  //Check user role

  Future checkUser(String email, String password) async {
    try {
      print(email);
      await clientCollection
          .where("email", isEqualTo: email)
          .get()
          .then((value) {
        value.docs.forEach((snapshot) {
          if (snapshot.data()['email'] == email) {
            AuthService().signInWithEmailAndPassword(email, password);
          }
        });
      }).onError((error, stackTrace) => null);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //Update

  Future bookLensman(String client_id, String lensman_id) async {
    return await bookingCollection
        .add({
          'client_id': 'client_id',
          'lensman_id': 'lensman_id',
          'status': 'pending',
        })
        .then((value) => print("Booking Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //get client streams

  Stream<List<Lensman>> get lensman {
    return employeeCollection.snapshots().map(_lensmanListFromSnapshot);
  }
}
