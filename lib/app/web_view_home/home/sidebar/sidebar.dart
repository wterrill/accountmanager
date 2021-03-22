import 'package:accountmanager/app/web_view_home/app_page/tbr_selection/start_tbr.dart';
import 'package:accountmanager/app/web_view_home/home/developer/developer_page.dart';
import 'package:accountmanager/app/web_view_home/home/developer/other_plasma1.dart';
import 'package:accountmanager/app/web_view_home/home/sidebar/sidebar_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/app/web_view_home/account/account_page.dart';
import 'package:accountmanager/app/web_view_home/assign_TBR/assign_tbr_page.dart';
import 'package:accountmanager/app/web_view_home/create_company/create_company_page.dart';
import 'package:accountmanager/app/web_view_home/create_technician/create_tech_page.dart';
import 'package:accountmanager/app/web_view_home/overview/overview_page.dart';
import 'package:flutter/widgets.dart' as listening;
import 'package:flutter/widgets.dart';

class MyFlutterApp {
  MyFlutterApp._();

  static const _kFontFam = 'MyFlutterApp';
  static const String _kFontPkg = null;

  static const IconData user =
      IconData(0xf007, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class Sidebar extends ConsumerWidget {
  const Sidebar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // int _downCounter = 0;
    // int _upCounter = 0;
    double x = 0.0;
    double y = 0.0;

    void _updateLocation(PointerEvent details) {
      // setState(() {
      x = details.position.dx;
      y = details.position.dy;
      print('x=$x   y=$y');
    }

    // );
    void _incrementDown(PointerEvent details) {
      _updateLocation(details);
      // setState(() {
      // _downCounter++;
      // });
    }

    void _incrementUp(PointerEvent details) {
      _updateLocation(details);
      // setState(() {
      // _upCounter++;
      // });
    }

    // const TextStyle buttonStyle = TextStyle(color: Colors.white, fontSize: 16);
    // Widget widget = watch(widgetProvider).state;
    final String lastText = watch(sideBarButtonStateProvider).state;
    final sidebar = Container(
      width: 250,
      // color: const Color(0xFF1B2E44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(''),
          SidebarButton(
            lastText: lastText,
            text: 'Overview',
            faIcon: FontAwesomeIcons.home,
            onPressedx: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.pink[100], child: OverviewWebPage()));
            },
          ),
          SidebarButton(
            lastText: lastText,
            text: 'Assign Evaluation',
            faIcon: FontAwesomeIcons.plusSquare,
            onPressedx: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.blue[100], child: AssignTBRWebPage()));
            },
          ),
          SidebarButton(
            lastText: lastText,
            text: 'Add Company',
            // faIcon: FontAwesomeIcons.building,
            imageIcon: Image.asset('assets/icon/add_company.gif'),
            onPressedx: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.green[100], child: CreateCompanyWebPage()));
            },
          ),
          SidebarButton(
            lastText: lastText,
            text: 'Add Employee',
            // faIcon: MyFlutterApp.user, //FontAwesomeIcons.user,
            imageIcon: Image.asset('assets/icon/add_user_will.png'),
            onPressedx: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.green[200], child: CreateTechWebPage()));
            },
          ),
          // SidebarButton(
          //   lastText: lastText,
          //   text: 'View Roadmap',
          //   faIcon: FontAwesomeIcons.road,
          //   onPressedx: () {
          //     context.read(widgetProvider).state = Expanded(
          //         child: Container(
          //             color: Colors.green[300],
          //             child: const Center(
          //                 child:
          //                     Text('I really have no idea what to put here'))));
          //   },
          // ),
          // SidebarButton(
          //   lastText: lastText,
          //   text: 'Edit Questions',
          //   faIcon: FontAwesomeIcons.edit,
          //   onPressedx: () {
          //     context.read(widgetProvider).state = Expanded(
          //         child: Container(
          //             color: Colors.brown[50], child: QuestionWebPage()));
          //   },
          // ),
          SidebarButton(
            lastText: lastText,
            text: 'Account Info',
            faIcon: FontAwesomeIcons.user,
            onPressedx: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.brown[150], child: AccountWebPage()));
            },
          ),
          SidebarButton(
            lastText: lastText,
            text: 'App Page - Web',
            // faIcon: FontAwesomeIcons.web,
            imageIcon: const Icon(Icons.web, color: Colors.white),
            onPressedx: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.purple[50],
                      child: const SelectTBRPage(mobile: false)));
            },
          ),
          // SidebarButton(
          //   lastText: lastText,
          //   text: 'App Page: Mobile',
          //   faIcon: FontAwesomeIcons.mobileAlt,
          //   onPressedx: () {
          //     context.read(widgetProvider).state = Expanded(
          //         child: Center(
          //             child:
          //                 addMobileFrame(const SelectTBRPage(mobile: true))));
          //   },
          // ),
          // SidebarButton(
          //   lastText: lastText,
          //   text: 'App Page: Tablet',
          //   faIcon: FontAwesomeIcons.mobileAlt,
          //   onPressedx: () {
          //     context.read(widgetProvider).state = Expanded(
          //         child: Center(
          //             child:
          //                 addTabletFrame(const SelectTBRPage(mobile: true))));
          //   },
          // ),
          const Text(''),
          const Text(''),
          SidebarButton(
            lastText: lastText,
            text: 'Dev Testing',
            faIcon: FontAwesomeIcons.atom,
            onPressedx: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.brown[150], child: const DeveloperPage()));
            },
          ),
          const Text(''),
        ],
      ),
    );
    //     return listening.Listener(
    //       onPointerDown: _incrementDown,
    //       onPointerMove: _updateLocation,
    //       onPointerUp: _incrementUp,
    //       child: CustomPaint(
    //         painter: BluePainter(),
    //         child: sidebar,
    //   ),
    // );

    return listening.Listener(
      onPointerDown: _incrementDown,
      onPointerMove: _updateLocation,
      onPointerUp: _incrementUp,
      child: Stack(children: [
        Container(
          width: 250,
          // child: OtherPlasma2(),
          // child: FancyPlasmaWidget1(),
          // child: FancyPlasmaWidget2(),
          child: OtherPlasma1(),
        ),
        sidebar
      ]),
    );
  }
}

Widget addMobileFrame(Widget childWidget) {
  const double heightbase = 790.0;
  const double widthbase = heightbase / 1.9;
  const double innerheight = heightbase - 30;
  const double innerwidth = widthbase - 30;

  return Stack(children: [
    Align(
      alignment: Alignment.center,
      child: Container(
          height: innerheight,
          width: innerwidth,
          color: Colors.purple[50],
          child: childWidget),
    ),
    IgnorePointer(
      child: Align(
        alignment: Alignment.center,
        child: Container(
            width: widthbase,
            height: heightbase,
            // color: Colors.green,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset('assets/images/mobileFrame2.png'),
            )),
      ),
    ),
  ]);
}

Widget addTabletFrame(Widget childWidget) {
  const double heightbase = 790.0;
  const double widthbase = heightbase / 1.3;
  const double innerheight = heightbase - 60;
  const double innerwidth = widthbase - 60;

  return Stack(children: [
    Align(
      alignment: Alignment.center,
      child: Container(
        height: innerheight,
        width: innerwidth,
        color: Colors.purple[50],
        child: DefaultTextStyle(
            style: const TextStyle(fontSize: 50, color: Colors.blue),
            child: childWidget),
      ),
    ),
    IgnorePointer(
      child: Align(
        alignment: Alignment.center,
        child: Container(
            width: widthbase,
            height: heightbase,
            // color: Colors.green,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset('assets/images/tabletFrame.png'),
            )),
      ),
    ),
  ]);
}
