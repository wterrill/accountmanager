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
