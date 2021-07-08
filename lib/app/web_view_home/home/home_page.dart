import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/home/developer/other_plasma1.dart';
import 'package:accountmanager/app/web_view_home/home/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:accountmanager/services/firestore_database.dart';
import 'package:accountmanager/models/tbr_in_progress.dart';
import 'header.dart';

late Box<TBRinProgress> globalBoxTBRinProgress;

class WebViewHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var boxFuture = Hive.openBox<TBRinProgress>('globalTBRinProgress');
    boxFuture.then((result) {
      globalBoxTBRinProgress = result;
    });
    final FirestoreDatabase? firestoreDatabase = context.read(databaseProvider);
    final Map<String, String>? registeredData =
        context.read(registeredProvider).getValue;
    if (registeredData.toString() != '{null: null}') {
      print('firestoreDatabase reads: $firestoreDatabase');
      print('just before saveUserInfo');
      firestoreDatabase!.saveUserInfo(registeredData!['uid'], registeredData);
    }
    context.read(registeredProvider).reset();
    final Widget incomingWidget = watch(widgetProvider).state;
    print('home page build');
    return Scaffold(
      body: Stack(children: [
        OtherPlasma1(),
        Column(
          children: [
            const Header(),
            Expanded(
              child: Row(
                children: [
                  const Sidebar(),
                  incomingWidget,
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
