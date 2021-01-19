import 'package:accountmanager/app/home/assign_TBR/assign_tbr_page.dart';
import 'package:accountmanager/app/home/create_company/create_company_page.dart';
import 'package:accountmanager/app/home/create_technician/create_tech_page.dart';
import 'package:accountmanager/app/home/overview/overview_page.dart';
import 'package:accountmanager/app/home/question/question_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:accountmanager/app/home/account/account_page.dart';
import 'package:accountmanager/app/home/cupertino_home_scaffold.dart';
import 'package:accountmanager/app/home/entries/entries_page.dart';
import 'package:accountmanager/app/home/jobs/jobs_page.dart';
import 'package:accountmanager/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.account;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
    TabItem.createTech: GlobalKey<NavigatorState>(),
    TabItem.assignTbr: GlobalKey<NavigatorState>(),
    TabItem.questionEdit: GlobalKey<NavigatorState>()
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobsPage(),
      TabItem.entries: (_) => EntriesPage(),
      TabItem.account: (_) => AccountPage(),
      TabItem.createTech: (_) => CreateTechPage(),
      TabItem.assignTbr: (_) => AssignTBRPage(),
      TabItem.addCompany: (_) => CreateCompanyPage(),
      TabItem.overview: (_) => OverviewPage(),
      TabItem.questionEdit: (_) => QuestionPage(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
