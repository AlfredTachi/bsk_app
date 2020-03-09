import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rxdart/rxdart.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String name;
  String email;
  String imageUrl;

  Future<FirebaseUser> get getUser => _firebaseAuth.currentUser();

  Stream<FirebaseUser> get user => _firebaseAuth.onAuthStateChanged;

  // Sign in with google
  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );
  // Future<String> signInWithGoogle() async {
  //     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
  //     if (googleUser == null) return null;
  //     final AuthCredential credential = GoogleAuthProvider.getCredential(
  //       idToken:  googleAuth.idToken,
  //       accessToken:  googleAuth.accessToken,
  //     );

  //     final FirebaseUser user = (await _firebaseAuth.signInWithCredential(credential)).user;

  //     // checking if users info not null
  //     if (user.displayName != null) name = user.displayName;
  //     if (user.email != null) email = user.email;
  //     if (user.photoUrl != null) imageUrl = user.photoUrl;

  //     if (!user.isAnonymous && await user.getIdToken() != null){
  //       final FirebaseUser currentUser = await _firebaseAuth.currentUser();
  //       if(user.uid == currentUser.uid) {
  //         return 'sign in with google succeeded: $user';
  //       }
  //     }
  //     return null;
  // }

  void updateUserData(FirebaseUser user) async {

  }


  // Email and Password Sign Up
  Future<FirebaseUser> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final FirebaseUser currentUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password))
        .user;

    // Update the username
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();

    return currentUser;
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

  // sign in anon
  Future<FirebaseUser> anonLogin() async {
    try {
      FirebaseUser user = (await _firebaseAuth.signInAnonymously()).user;
      return user;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }


  // Sign Out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('error logging out');
    }
  }
}
