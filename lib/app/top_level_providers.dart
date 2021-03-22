import 'package:accountmanager/app/web_view_home/overview/overview_page.dart';
import 'package:accountmanager/models/assignedTbr.dart';
import 'package:accountmanager/models/question.dart';
import 'package:accountmanager/models/tbr.dart';
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

final completedTbrStreamProvider =
    StreamProvider.family<TBRinProgress, String>((ref, jobId) {
  final database = ref.watch(databaseProvider);
  final questions = ref.watch(latestQuestionsProvider).state;
  return database != null && jobId != null
      ? database.completedTbrStream(completedTbrId: jobId, questions: questions)
      : const Stream.empty();
});

final currentAssignedTbrProvider = StateProvider<AssignedTBR>((ref) {
  print('currentAssignedTbrProvider ** ** **');
  return null;
});
final questionStreamProvider =
    StreamProvider.autoDispose<List<Question>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.questionStream() ?? const Stream.empty();
});

final latestQuestionsProvider = StateProvider<List<Question>>((ref) {
  return null;
});

final tbrInProgressProvider = StateProvider<TBRinProgress>((ref) {
  return TBRinProgress();
});

final widgetProvider = StateProvider<Widget>((ref) {
  return Expanded(
      child: Container(color: Colors.pink[100], child: OverviewWebPage()));
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
