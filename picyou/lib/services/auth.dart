import 'package:firebase_auth/firebase_auth.dart';
import 'package:picyou/model/user.dart';

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
}
