import 'package:firebase_auth/firebase_auth.dart';
import 'package:bsk_app/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

String name = '';
String email = '';
String imageUrl = '';

// Sign in with google
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<FirebaseUser> signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    idToken: googleAuth.idToken,
    accessToken: googleAuth.accessToken,
  );

  if (googleUser == null) {
    return null;
  }

  final FirebaseUser user =
      (await _firebaseAuth.signInWithCredential(credential)).user;

  // checking if users info not null
  // assert(user.displayName != null);
  // assert(user.email != null);
  // assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;

  // assert(!user.isAnonymous);
  // assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _firebaseAuth.currentUser();
  assert(user.uid == currentUser.uid);

  return user;
}

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/


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
  Future<User> anonLogin() async {
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
  Future<User> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      return _userFromFirebaseUer(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
