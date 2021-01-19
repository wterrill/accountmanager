import 'package:flutter/material.dart';
import 'package:accountmanager/constants/keys.dart';
import 'package:accountmanager/constants/strings.dart';

enum TabItem {
  account,
  createTech,
  assignTbr,
  addCompany,
  overview,
  jobs,
  entries,
  questionEdit
}

class TabItemData {
  const TabItemData(
      {@required this.key, @required this.title, @required this.icon});

  final String key;
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.account: TabItemData(
      key: Keys.accountTab,
      title: Strings.account,
      icon: Icons.person,
    ),
    TabItem.createTech: TabItemData(
      key: Keys.createTechTab,
      title: Strings.createTech,
      icon: Icons.access_alarms,
    ),
    TabItem.assignTbr: TabItemData(
      key: Keys.assignTbrTab,
      title: Strings.assignTbr,
      icon: Icons.airline_seat_flat_angled,
    ),
    TabItem.addCompany: TabItemData(
        key: Keys.addCompanyTab,
        title: Strings.addCompany,
        icon: Icons.two_wheeler),
    TabItem.overview: TabItemData(
      key: Keys.overviewTab,
      title: Strings.overview,
      icon: Icons.whatshot,
    ),
    TabItem.jobs: TabItemData(
      key: Keys.jobsTab,
      title: Strings.jobs,
      icon: Icons.work,
    ),
    TabItem.entries: TabItemData(
      key: Keys.entriesTab,
      title: Strings.entries,
      icon: Icons.view_headline,
    ),
    TabItem.questionEdit: TabItemData(
      key: Keys.questionTab,
      title: Strings.questionEdit,
      icon: Icons.question_answer_rounded,
    ),
  };
}
