library firebase_auth_service;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

String filename = 'firebase_auth_service.dart: ';

@immutable
class AppUser {
  const AppUser({
    required this.uid,
    this.email,
    this.photoURL,
    this.displayName,
  });

  final String uid;
  final String? email;
  final String? photoURL;
  final String? displayName;

  factory AppUser.fromFirebaseUser(User? user) {
    if (user == null) {
      return AppUser(
        uid: DateTime.now(),
        email: 'Error',
        displayName: 'Error',
        photoURL: 'Error',
      );
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
