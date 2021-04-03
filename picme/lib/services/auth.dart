import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:picme/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  //create user model

  UserCreds _userFromFirebaseUser(User user) {
    return user != null
        ? UserCreds(uid: user.uid, anon: user.isAnonymous)
        : null;
  }

  //auth change
  Stream<UserCreds> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in fb

  //sign in Goggle

  Future signInWithGoogle() async {
    try {
      final guser = await googleSignIn.signIn();

      final googleAuth = await guser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign out

  Future signOutUser() async {
    try {
      await googleSignIn.disconnect();
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
