// https://blog.codemagic.io/flutter-web-firebase-authentication-and-google-sign-in/

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;

bool authSignedIn;

String uid;

String userEmail;

Future<String> registerWithEmailPassword(String email, String password) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final UserCredential userCredential = await _auth
      .createUserWithEmailAndPassword(email: email, password: password);

  final User user = userCredential.user;
  if (user != null) {
    assert(user.uid != null);
    assert(user.email != null);

    uid = user.uid;
    userEmail = user.email;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    return 'Successfull registered, User UID: ${user.uid}';
  }
  return null;
}

Future<String> signInWithEmailPassword(String email, String password) async {
  // Initialize Firebase
  await Firebase.initializeApp();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);

  final User user = userCredential.user;

  if (user != null) {
    // checking if uid or email is null
    assert(user.uid != null);
    assert(user.email != null);

    uid = user.uid;
    userEmail = user.email;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);

    return 'Successfully logged in, User UID: ${user.uid}';
  }
  return null;
}

Future<String> signOut() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  userEmail = null;

  return 'User signed out';
}
