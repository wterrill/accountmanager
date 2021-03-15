// ignore_for_file: unused_import
// ignore_for_file: avoid_unnecessary_containers
import 'package:accountmanager/web_view_home/home/developer/other_plasma1.dart';
import 'package:accountmanager/web_view_home/home/developer/plasma.dart';
import 'package:accountmanager/web_view_home/home/sidebar/custom_background2.dart';
import 'package:flutter/material.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // child: AnimationWrapper(),
        // child: FancyPlasma1());
        child: OtherPlasma1()
        // child: FancyPlasmaWidget2()
        // child: FancyPlasmaWidget1()
        );
  }
}
