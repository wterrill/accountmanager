import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accountmanager/app/home/tab_item.dart';
import 'package:accountmanager/constants/keys.dart';
import 'package:accountmanager/routing/cupertino_tab_view_router.dart';

@immutable
class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.widgetBuilders,
    @required this.navigatorKeys,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        key: const Key(Keys.tabBar),
        items: [
          _buildBottomNavigationBarItem(TabItem.jobs),
          _buildBottomNavigationBarItem(TabItem.entries),
          _buildBottomNavigationBarItem(TabItem.account),
          _buildBottomNavigationBarItem(TabItem.createTech),
        ],
        onTap: (index) {
          return onSelectTab(TabItem.values[index]);
        },
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item],
          builder: (context) => widgetBuilders[item](context),
          onGenerateRoute: CupertinoTabViewRouter.generateRoute,
        );
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.indigo : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        color: color,
      ),
      label: itemData.title,
    );
  }
}
