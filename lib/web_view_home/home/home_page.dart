import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/web_view_home/home/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

import 'header.dart';

class WebViewHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Widget incomingWidget = watch(widgetProvider).state;
    print('home page build');
    return Scaffold(
      body:
          // Container(
          // color: Colors.red,
          // child:
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
      // ),
    );
  }
}
