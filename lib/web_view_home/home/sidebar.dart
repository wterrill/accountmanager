import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/all.dart';

import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/web_view_home/account/account_page.dart';
import 'package:accountmanager/web_view_home/app_page/tbr/tbr_app_page.dart';
import 'package:accountmanager/web_view_home/assign_TBR/assign_tbr_page.dart';
import 'package:accountmanager/web_view_home/create_company/create_company_page.dart';
import 'package:accountmanager/web_view_home/create_technician/create_tech_page.dart';
import 'package:accountmanager/web_view_home/overview/overview_page.dart';
import 'package:accountmanager/web_view_home/question/question_edit_page.dart';
import 'package:flutter/widgets.dart' as listening;
import 'package:flutter/widgets.dart';

final sideBarButtonStateProvider = StateProvider<String>((ref) {
  return 'none';
});

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
    int _downCounter = 0;
    int _upCounter = 0;
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
      _downCounter++;
      // });
    }

    void _incrementUp(PointerEvent details) {
      _updateLocation(details);
      // setState(() {
      _upCounter++;
      // });
    }

    // const TextStyle buttonStyle = TextStyle(color: Colors.white, fontSize: 16);
    // Widget widget = watch(widgetProvider).state;
    String lastText = watch(sideBarButtonStateProvider).state;
    return listening.Listener(
      onPointerDown: _incrementDown,
      onPointerMove: _updateLocation,
      onPointerUp: _incrementUp,
      child: CustomPaint(
        painter: BluePainter(),
        child: Container(
          width: 250,
          // color: const Color(0xFF1B2E44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(''),
              SidebarButton(
                lastText: lastText,
                text: 'Home',
                faIcon: FontAwesomeIcons.home,
                onPressedx: () {
                  context.read(widgetProvider).state = Expanded(
                      child: Container(
                          color: Colors.pink[100], child: OverviewWebPage()));
                },
              ),
              SidebarButton(
                lastText: lastText,
                text: 'Create Evaluation',
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
                          color: Colors.green[100],
                          child: CreateCompanyWebPage()));
                },
              ),
              SidebarButton(
                lastText: lastText,
                text: 'Add Technician',
                // faIcon: MyFlutterApp.user, //FontAwesomeIcons.user,
                imageIcon: Image.asset('assets/icon/add_user_will.png'),
                onPressedx: () {
                  context.read(widgetProvider).state = Expanded(
                      child: Container(
                          color: Colors.green[200],
                          child: CreateTechWebPage()));
                },
              ),
              SidebarButton(
                lastText: lastText,
                text: 'View Roadmap',
                faIcon: FontAwesomeIcons.road,
                onPressedx: () {
                  context.read(widgetProvider).state = Expanded(
                      child: Container(
                          color: Colors.green[300],
                          child: const Center(
                              child: Text(
                                  'I really have no idea what to put here'))));
                },
              ),
              SidebarButton(
                lastText: lastText,
                text: 'App Page',
                faIcon: FontAwesomeIcons.mobileAlt,
                onPressedx: () {
                  context.read(widgetProvider).state = Expanded(
                      child: Container(
                          color: Colors.purple[50], child: const TBRappPage()));
                },
              ),
              SidebarButton(
                lastText: lastText,
                text: 'Edit Questions',
                faIcon: FontAwesomeIcons.edit,
                onPressedx: () {
                  context.read(widgetProvider).state = Expanded(
                      child: Container(
                          color: Colors.brown[50], child: QuestionWebPage()));
                },
              ),
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
              const Text(''),
            ],
          ),
        ),
      ),
    );
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final Paint paint = Paint();

    final Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = const Color(0xFF1B2E44); //Colors.blue.shade700;
    // paint.maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0);
    canvas.drawPath(mainBackground, paint);

    final Path ovalPath = Path();
    // start paint from 20% height to the left
    ovalPath.moveTo(0, height * 0.1);
    // paint a curve from current position to the middle of the screen
    ovalPath.quadraticBezierTo(
        width * 0.45, height * 0.25, width / 2, height / 2);
    paint.color = const Color(0xFF183453);
    // paint a curve from the current position to the bottom left of the screen * 0.1
    ovalPath.quadraticBezierTo(width * 0.58, height * 0.8, width * 0.1, height);
    // draw remaining line from the current position to the lower left corner
    ovalPath.lineTo(0, height);
    // close line to reset it

    ovalPath.close();
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(BluePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BluePainter oldDelegate) => false;
}

class SidebarButton extends ConsumerWidget {
  const SidebarButton(
      {Key key,
      this.text,
      this.faIcon,
      this.onPressedx,
      this.lastText,
      this.imageIcon})
      : super(key: key);

  // final TextStyle buttonStyle;
  final String text;
  final IconData faIcon;
  final Function onPressedx;
  final String lastText;
  final Widget imageIcon;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    bool selected;
    if (lastText == text) {
      selected = true;
    } else {
      selected = false;
    }
    Widget image = imageIcon;
    if (faIcon != null) {
      image = FaIcon(
        faIcon,
        color: Colors.white,
      );
    }
    print(image);
    return TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(10),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            // text color
            (Set<MaterialState> states) =>
                states.contains(MaterialState.selected)
                    ? Colors.red
                    : Colors.blue,
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              // background color    this is color:
              (Set<MaterialState> states) {
            Color finalColor = Colors.black;
            if (states.contains(MaterialState.hovered)) {
              finalColor = Colors.green;
            }

            if (states.contains(MaterialState.pressed)) {
              finalColor = const Color(0xFF29588F);
            }
            return selected ? Colors.white.withAlpha(22) : finalColor;
            // return finalColor;
          }),
          shadowColor: MaterialStateProperty.resolveWith<Color>(
            // text color
            (Set<MaterialState> states) =>
                states.contains(MaterialState.hovered)
                    ? Colors.red
                    : Colors.blue,
          ),

          // shape: MaterialStateProperty.all(
          //   RoundedRectangleBorder(
          // borderRadius: BorderRadius.all(
          //   Radius.circular(50),
          // ),
          //       side: BorderSide(color: Colors.pink, width: 3.0)),
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(children: [
            Container(
              width: 35,
              height: 35,
              child: FittedBox(child: image
                  // child: FaIcon(
                  //   faIcon,
                  //   color: Colors.white,
                  // ),
                  ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 16))
          ]),
        ),
        onPressed: () {
          onPressedx.call();
          context.read(sideBarButtonStateProvider).state = text;
        });
  }
}
