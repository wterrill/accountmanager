import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/web_view_home/home/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:accountmanager/app/home/tab_item.dart';
import 'package:hooks_riverpod/all.dart';

import 'header.dart';

class WebViewHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Widget displayedPage = Expanded(
        child: Container(
            // color: Colors.green,
            child: const Center(child: Text('this is the displayed page'))));
    Widget incomingWidget = watch(widgetProvider).state;
    print('home page build');
    return Scaffold(
      body: Container(
        // color: Colors.red,
        child: Column(
          children: [
            Header(),
            Expanded(
              child: Row(
                children: [
                  Container(color: Colors.blue, width: 200, child: Sidebar()),
                  incomingWidget,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
