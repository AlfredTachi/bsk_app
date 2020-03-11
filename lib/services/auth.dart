import 'package:firebase_auth/firebase_auth.dart';
import 'package:bsk_app/models/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rxdart/rxdart.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // create user Object based on FirebaseUser
  User _userFromFirebaseUer(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged
      .map(_userFromFirebaseUer);
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print('error logging out');
      return null;
    }
  }
  // sign in anon
  Future/*<FirebaseUser>*/ anonLogin() async {
    try {
      FirebaseUser user = (await _firebaseAuth.signInAnonymously()).user;
      return _userFromFirebaseUer(user);
    } catch (err) {
      print(err + 'error creating anon user');
      return null;
    }
  }
  // Email and Password Sign Up
  Future<FirebaseUser> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final FirebaseUser currentUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password))
        .user;

      // Update the username
      var userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = name;
      await currentUser.updateProfile(userUpdateInfo);
      await currentUser.reload();

    return currentUser;
    } catch (e) {
      print("error create User");
      return null;
    }
  }

  // Email and Password Sign In
  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      return user;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }



}
