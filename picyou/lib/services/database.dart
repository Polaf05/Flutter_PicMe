import 'dart:ffi';

import "package:cloud_firestore/cloud_firestore.dart";

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
      List<String> gallery,
      String displayPicture,
      String role,) async {
    return await lensmenCollection.doc(uid).set({
      'username' : username,
      'name' : name,
      'address' : address,
      'contact' : contact,
      'email' : email,
      'gallery' : gallery,
      'displayPicture': displayPicture,
      'role': role,
    });
  }
}
