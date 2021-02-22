import 'package:accountmanager/app/top_level_providers.dart';
import 'package:accountmanager/web_view_home/account/account_page.dart';
import 'package:accountmanager/web_view_home/app_page/tbr/tbr_app_page.dart';
import 'package:accountmanager/web_view_home/assign_TBR/assign_tbr_page.dart';
import 'package:accountmanager/web_view_home/create_company/create_company_page.dart';
import 'package:accountmanager/web_view_home/create_technician/create_tech_page.dart';
import 'package:accountmanager/web_view_home/overview/overview_page.dart';
import 'package:accountmanager/web_view_home/question/question_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    const TextStyle buttonStyle = TextStyle(color: Colors.white, fontSize: 16);
    // Widget widget = watch(widgetProvider).state;
    return Container(
      width: 200,
      color: const Color(0xFF1B2E44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(''),
          TextButton(
            child: const Text('Home', style: buttonStyle),
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.pink[100], child: OverviewWebPage()));
            },
          ),
          TextButton(
            child: const Text('Create Evaluation', style: buttonStyle),
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.blue[100], child: AssignTBRWebPage()));
            },
          ),
          TextButton(
            child: const Text('Add Company', style: buttonStyle),
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.green[100], child: CreateCompanyWebPage()));
            },
          ),
          TextButton(
            child: const Text('Add Technician', style: buttonStyle),
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.green[100], child: CreateTechWebPage()));
            },
          ),
          TextButton(
            child: const Text('View Roadmap', style: buttonStyle),
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.green[100],
                      child: const Center(
                          child:
                              Text('I really have no idea what to put here'))));
            },
          ),
          TextButton(
            child: const Text('App Page', style: buttonStyle),
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.purple[50], child: const TBRappPage()));
            },
          ),
          TextButton(
            child: const Text('Edit Questions', style: buttonStyle),
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.brown[50], child: QuestionWebPage()));
            },
          ),
          TextButton(
            child: const Text('Account Info', style: buttonStyle),
            onPressed: () {
              context.read(widgetProvider).state = Expanded(
                  child: Container(
                      color: Colors.brown[50], child: AccountWebPage()));
            },
          ),
          const Text(''),
        ],
      ),
    );
  }
}
