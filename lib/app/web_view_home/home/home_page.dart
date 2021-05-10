import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/home/developer/other_plasma1.dart';
import 'package:accountmanager/app/web_view_home/home/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../services/firestore_database.dart';
import 'header.dart';

class WebViewHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
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
