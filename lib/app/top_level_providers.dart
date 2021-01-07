import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:accountmanager/services/firestore_database.dart';

// There are three top-level providers:
// firebase auth -> This becomes a streamProvider
// database provider
// logger provider
String filename = 'top_level_providers.dart:';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  print('$filename firebaseAuthProvider instance');
  return FirebaseAuth.instance;
});

final authStateChangesProvider = StreamProvider<User>((ref) {
  print('$filename ref.watch(firebaseAuthProvider).authStateChanges()');
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final databaseProvider = Provider<FirestoreDatabase>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  print('$filename databaseProvider: ${auth.data?.value?.uid}');

  if (auth.data?.value?.uid != null) {
    return FirestoreDatabase(uid: auth.data?.value?.uid);
  }
  return null;
});

final loggerProvider = Provider<Logger>((ref) {
  print('$filename loggerProvider PrettyPrinter');
  return Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      printEmojis: false,
    ),
  );
});
