library firebase_auth_service;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

String filename = 'firebase_auth_service.dart: ';

@immutable
class AppUser {
  const AppUser({
    @required this.uid,
    this.email,
    this.photoURL,
    this.displayName,
  }) : assert(uid != null, 'User can only be created with a non-null uid');

  final String uid;
  final String email;
  final String photoURL;
  final String displayName;

  factory AppUser.fromFirebaseUser(User user) {
    print('$filename AppUser.fromFirebaseUser');
    if (user == null) {
      return null;
    }
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }

  @override
  String toString() =>
      'uid: $uid, email: $email, photoUrl: $photoURL, displayName: $displayName';
}

// class FirebaseAuthService {
//   FirebaseAuthService() {
//     print('$filename FirebaseAuthService constructed');
//   }

//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   Stream<AppUser> authStateChanges() {
//     return _firebaseAuth
//         .authStateChanges()
//         .map((user) => AppUser.fromFirebaseUser(user));
//   }

//   Future<AppUser> signInAnonymously() async {
//     final userCredential = await _firebaseAuth.signInAnonymously();
//     return AppUser.fromFirebaseUser(userCredential.user);
//   }

//   Future<AppUser> signInWithEmailAndPassword(
//       String email, String password) async {
//     print('$filename entered signInWithEmailAndPassword');
//     final userCredential =
//         await _firebaseAuth.signInWithCredential(EmailAuthProvider.credential(
//       email: email,
//       password: password,
//     ));
//     return AppUser.fromFirebaseUser(userCredential.user);
//   }

//   Future<AppUser> createUserWithEmailAndPassword(
//       String email, String password) async {
//     final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email, password: password);
//     return AppUser.fromFirebaseUser(userCredential.user);
//   }

//   Future<void> sendPasswordResetEmail(String email) async {
//     await _firebaseAuth.sendPasswordResetEmail(email: email);
//   }

//   AppUser get currentUser =>
//       AppUser.fromFirebaseUser(_firebaseAuth.currentUser);

//   Future<void> signOut() async {
//     return _firebaseAuth.signOut();
//   }
// }
