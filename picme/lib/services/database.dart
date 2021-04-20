import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection references

  final CollectionReference clientCollection =
      FirebaseFirestore.instance.collection('Clients');

  //Update

  Future updateUserData(String email, String name, String role) async {
    return await clientCollection.doc(uid).set({
      'email': email,
      'name': name,
      'role': role,
    });
  }

  //get client streams

  Stream<QuerySnapshot> get user {
    return clientCollection.snapshots();
  }
}
