// import 'package:accountmanager/app/web_view_home/overview/overview_page.dart';
import 'package:accountmanager/app/web_view_home/overview/start_page.dart';
import 'package:accountmanager/models/assigned_tbr.dart';
import 'package:accountmanager/models/business_reasons.dart';
import 'package:accountmanager/models/question.dart';
import 'package:accountmanager/models/tbr.dart';
import 'package:accountmanager/models/technician.dart';
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

final StreamProviderFamily<TBRinProgress, String>? completedTbrStreamProvider =
    StreamProvider.family<TBRinProgress, String>((ref, id) {
  final database = ref.watch(databaseProvider);
  final questions = ref.watch(latestQuestionsProvider).state;
  return database != null //&& id != null
      ? database.completedTbrStream(completedTbrId: id, questions: questions)
      : const Stream.empty();
});

final assignedTbrProvider = StateProvider<AssignedTBR?>((ref) {
  return null;
});

final AutoDisposeStreamProvider<List<Question>>? questionStreamProvider =
    StreamProvider.autoDispose<List<Question>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.questionStream() ?? const Stream.empty();
});

final latestQuestionsProvider = StateProvider<List<Question>?>((ref) {
  return null;
});

final AutoDisposeStreamProvider<BusinessReasons> businessReasonsStreamProvider =
    StreamProvider.autoDispose<BusinessReasons>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.businessReasonsStream() ?? const Stream.empty();
});

final latestBusinessReasonsProvider = StateProvider<BusinessReasons?>((ref) {
  return null;
});

final AutoDisposeStreamProvider<List<Technician>>?
    asyncTechnicianStreamProvider =
    StreamProvider.autoDispose<List<Technician>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.technicianStream() ?? const Stream.empty();
});

final techniciansProvider = StateProvider<List<Technician>?>((ref) {
  return null;
});

final tbrInProgressProvider = StateProvider<TBRinProgress?>((ref) {
  return TBRinProgress();
});

final widgetProvider = StateProvider<Widget>((ref) {
  return const Expanded(
    child: OverviewWebPage(
      mobile: false,
    ),
  );
});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  final FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  return firebaseAuthInstance;
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final Stream<User?> userDataStream =
      ref.watch(firebaseAuthProvider).authStateChanges();
  return userDataStream;
});

final databaseProvider = Provider<FirestoreDatabase?>((ref) {
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

class RegisteredClass {
  Map<String, String>? currentValue;
  RegisteredClass() {
    currentValue = {'null': 'null'};
  }

  void reset() {
    currentValue = {'null': 'null'};
  }

  Map<String, String>? get getValue => currentValue;

// ignore: use_setters_to_change_properties
  void set(Map<String, String> newValue) {
    currentValue = newValue;
  }
}

class RegisteredClassNotifier extends StateNotifier<RegisteredClass> {
  RegisteredClassNotifier() : super(RegisteredClass());
}

final registeredProvider =
    StateNotifierProvider<RegisteredClassNotifier, RegisteredClass>(
        (ref) => RegisteredClassNotifier());

// class MyModel {}

// class MyStateNotifier extends StateNotifier<MyModel> {
//   MyStateNotifier() : super(MyModel());
// }

// final provider = StateNotifierProvider<MyStateNotifier, MyModel>((ref) {
//   return MyStateNotifier();
// });
