import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/home/developer/other_plasma1.dart';
import 'package:accountmanager/app/web_view_home/home/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'header.dart';

class WebViewHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    watch(registeredProvider).state = {'null': 'null'};
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
