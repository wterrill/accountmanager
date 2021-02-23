import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/web_view_home/account/account_page.dart';
import 'package:accountmanager/web_view_home/app_page/tbr/tbr_app_page.dart';
import 'package:accountmanager/web_view_home/assign_TBR/assign_tbr_page.dart';
import 'package:accountmanager/web_view_home/create_company/create_company_page.dart';
import 'package:accountmanager/web_view_home/create_technician/create_tech_page.dart';
import 'package:accountmanager/web_view_home/overview/overview_page.dart';
import 'package:accountmanager/web_view_home/question/question_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/all.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // const TextStyle buttonStyle = TextStyle(color: Colors.white, fontSize: 16);
    // Widget widget = watch(widgetProvider).state;
    return Container(
      width: 250,
      color: const Color(0xFF1B2E44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(''),
          SidebarButton(
            text: 'Home',
            faIcon: FontAwesomeIcons.home,
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.pink[100], child: OverviewWebPage()));
            },
          ),
          SidebarButton(
            text: 'Create Evaluation',
            faIcon: FontAwesomeIcons.plusSquare,
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.blue[100], child: AssignTBRWebPage()));
            },
          ),
          SidebarButton(
            text: 'Add Company',
            faIcon: FontAwesomeIcons.building,
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.green[100], child: CreateCompanyWebPage()));
            },
          ),
          SidebarButton(
            text: 'Add Technician',
            faIcon: FontAwesomeIcons.user,
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.green[200], child: CreateTechWebPage()));
            },
          ),
          SidebarButton(
            text: 'View Roadmap',
            faIcon: FontAwesomeIcons.road,
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.green[300],
                      child: const Center(
                          child:
                              Text('I really have no idea what to put here'))));
            },
          ),
          SidebarButton(
            text: 'App Page',
            faIcon: FontAwesomeIcons.mobileAlt,
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.purple[50], child: const TBRappPage()));
            },
          ),
          SidebarButton(
            text: 'Edit Questions',
            faIcon: FontAwesomeIcons.edit,
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.brown[50], child: QuestionWebPage()));
            },
          ),
          SidebarButton(
            text: 'Account Info',
            faIcon: FontAwesomeIcons.user,
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.brown[150], child: AccountWebPage()));
            },
          ),
          const Text(''),
        ],
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  const SidebarButton({
    Key key,
    // @required this.buttonStyle,
    this.text,
    this.faIcon,
    this.onPressed,
  }) : super(key: key);

  // final TextStyle buttonStyle;
  final String text;
  final IconData faIcon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(children: [
            Container(
              width: 35,
              height: 35,
              child: FittedBox(
                child: FaIcon(
                  faIcon,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 16))
          ]),
        ),
        onPressed: onPressed);
  }
}
