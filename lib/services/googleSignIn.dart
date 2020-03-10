import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';


final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String name;
  String email;
  String imageUrl;

  // Future<FirebaseUser> get getUser => _firebaseAuth.currentUser();

  // Stream<FirebaseUser> get user => _firebaseAuth.onAuthStateChanged;

  // Sign in with google
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Future<String> signInWithGoogle() async {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      if (googleUser == null) return null;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken:  googleAuth.idToken,
        accessToken:  googleAuth.accessToken,
      );

      final FirebaseUser user = (await _firebaseAuth.signInWithCredential(credential)).user;

      // checking if users info not null
      assert(user.displayName != null);
      assert(user.email != null);
      assert(user.photoUrl != null);

      name = user.displayName;
      email = user.email;
      imageUrl = user.photoUrl;

      assert(!user.isAnonymous); 
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      assert(user.uid == currentUser.uid);
      
      return 'sign in with google succeeded: $user';
  }

  Future<String> signOutGoogle() async {
    try {
      await googleSignIn.signOut();
      return 'sign in with google succeeded';
    } catch (e) {
      print('error logging out');
      return null;
    }
  }

