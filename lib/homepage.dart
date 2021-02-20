import 'package:flutter/cupertino.dart';
import 'today_page_tab.dart';
import 'statistics_page_tab.dart';
import 'mine_page_tab.dart';
import 'tasks_page_tab.dart';

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
            icon: Icon(CupertinoIcons.calendar_today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_dash),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar),
            label: 'Statistics'
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_circle),
            label: 'Mine'
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch(index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TodayPage(),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TasksPage(),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: StatisticsPage(),
              );
            });
          case 3:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: MinePage(),
              );
            });
        }
        return Text('hello' + index.toString());
      }
    )
    );
  }
}