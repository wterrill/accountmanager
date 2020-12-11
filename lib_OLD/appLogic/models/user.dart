import 'dart:math';

import 'package:meta/meta.dart';

@immutable
class L_User {
  const L_User({
    @required this.uid,
    this.email,
    this.photoURL,
    this.displayName,
  });

  final String uid;
  final String email;
  final String photoURL;
  final String displayName;
}
