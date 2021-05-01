import 'package:firebase_auth/firebase_auth.dart';
import 'package:picyou/model/user.dart';
import 'package:picyou/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebase
  UserCreds _userFromFirebaseUser(User user) {
    return user != null
        ? UserCreds(uid: user.uid, anon: user.isAnonymous, email: user.email)
        : null;
  }

  //auth change user stream
  Stream<UserCreds> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  //signin anon
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

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('errror signout');
    }
  }

  //forgotpassword
  Future forgotPassword(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  //register with email and password
  Future register(String username, String name, String address, String contact, String email, String password, List<String> gallery, String displayPicture, String role ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      
      //create new document
      await DatabaseService(uid: user.uid).updateUserData(username, name,
          address, contact, email, gallery, displayPicture, role);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
