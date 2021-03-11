import 'package:accountmanager/app/home/models/tbr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:flutter/material.dart';

// There are four top-level providers:
// firebase auth -> This becomes a streamProvider
// database provider
// logger provider
// tbrInProgress provider. This is used to pass values during development.

// final tbrInProgressProvider = Provider<TBRinProgress>((ref) {
//   return TBRinProgress();
// });

final tbrInProgressProvider = Provider((ref) {
  print('beer');
  TBRinProgress tbRinProgress = TBRinProgress();
  return tbRinProgress;
});

final newTbrInProgressProvider = StateProvider<TBRinProgress>((ref) {
  return TBRinProgress();
});

final widgetProvider = StateProvider<Widget>((ref) {
  return const Text('initialWidget');
});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateChangesProvider = StreamProvider<User>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final databaseProvider = Provider<FirestoreDatabase>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  if (auth.data?.value?.uid != null) {
    return FirestoreDatabase(uid: auth.data?.value?.uid);
  }
  return null;
});

final loggerProvider = Provider<Logger>((ref) {
  return Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      printEmojis: false,
    ),
  );
});
