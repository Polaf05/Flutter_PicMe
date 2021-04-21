import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:picme/models/user.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:picme/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final facebookSignIn = FacebookLogin();

  static String error;
  //create user model

  UserCreds _userFromFirebaseUser(User user) {
    return user != null
        ? UserCreds(uid: user.uid, anon: user.isAnonymous, email: user.email)
        : null;
  }

  //auth change
  Stream<UserCreds> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  getCurrentUser() {
    User user = _auth.currentUser;
    return _userFromFirebaseUser(user);
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
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register email & password
  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //Update database

      await DatabaseService(uid: user.uid)
          .updateUserData(email, name, "client");

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.message);
      error = e.message;
      return null;
    }
  }

  //sign in fb

  Future resultFacebookSignIn() async {
    FacebookLoginResult _result = await facebookSignIn.logIn(['email']);
    switch (_result.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("cancelledByUser");
        break;
      case FacebookLoginStatus.error:
        print("Error");
        break;
      case FacebookLoginStatus.loggedIn:
        await signInWithFacebook(_result);
        break;
    }
  }

  Future signInWithFacebook(FacebookLoginResult _result) async {
    try {
      FacebookAccessToken _accessToken = _result.accessToken;
      AuthCredential credential =
          FacebookAuthProvider.credential(_accessToken.token);
      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;

      //add database
      await DatabaseService(uid: user.uid)
          .updateUserData(user.email, user.displayName, "client");

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in Goggle

  Future signInWithGoogle() async {
    try {
      final guser = await googleSignIn.signIn();

      final googleAuth = await guser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;

      //add database
      await DatabaseService(uid: user.uid)
          .updateUserData(user.email, user.displayName, "client");

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Forgot Password

  Future forgotPassword(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  //sign out

  Future<void> signOutUser() async {
    try {
      await facebookSignIn.logOut();
      await googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
