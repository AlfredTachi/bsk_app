import 'package:firebase_auth/firebase_auth.dart';
import 'package:bsk_app/models/user.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // create user Object based on FirebaseUser
  User _userFromFirebaseUer(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebaseUer);
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
  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final FirebaseUser user = (await _firebaseAuth
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;

      return _userFromFirebaseUer(user);
    } catch (e) {
      print("error create User\n" + e.toString());
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
