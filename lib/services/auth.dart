import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  ///final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get getUser => _firebaseAuth.currentUser();

  Stream<FirebaseUser> get user => _firebaseAuth.onAuthStateChanged;

  // Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
  //   (FirebaseUser user) => user?.uid,
  // );

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

  // Sign in with google
  Future<FirebaseUser> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user =
          (await _firebaseAuth.signInWithCredential(credential)).user;
      updateUserData(user);

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> updateUserData(FirebaseUser user) {
    DocumentReference reportRef = _db.collection('reports').document(user.uid);

    return reportRef.setData({'uid': user.uid, 'lastActivity': DateTime.now()},
        merge: true);
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
