import 'package:flutter/cupertino.dart';
import 'tabs/tasks_tab.dart';
import 'tabs/statistics_tab.dart';
import 'tabs/mine_tab.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        left: false,
        right: false,
        top: false,
        child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.list_dash),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chart_bar), label: 'Statistics'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person_circle), label: 'Mine'),
              ],
            ),
            tabBuilder: (context, index) {
              switch (index) {
                case 0:
                  return CupertinoTabView(builder: (context) {
                    return CupertinoPageScaffold(
                      child: TasksTab(),
                    );
                  });
                case 1:
                  return CupertinoTabView(builder: (context) {
                    return CupertinoPageScaffold(
                      child: StatisticsTab(),
                    );
                  });
                case 2:
                  return CupertinoTabView(builder: (context) {
                    return CupertinoPageScaffold(
                      child: MineTab(),
                    );
                  });
              }
              return Text('hello' + index.toString());
            }));
  }
}
