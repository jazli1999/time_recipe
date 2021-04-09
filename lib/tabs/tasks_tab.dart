import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/models/app_state_model.dart';
import 'package:time_recipe/components/bottom_bar.dart';
import 'package:time_recipe/components/add_button.dart';
import 'package:time_recipe/components/logout.dart';
import 'package:time_recipe/tabs/tasks_by_category.dart';
import 'package:time_recipe/tabs/tasks_by_date.dart';

class TasksTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TasksTabState();
  }
}

class _TasksTabState extends State<TasksTab> {
  final tabs = {
    'category': Text('Category View'),
    'calendar': Text('Calendar View')
  };
  String selected = 'category';

  @override
  Widget build(BuildContext context) {
    Logout logout = new Logout(context: context);
    return Consumer<AppStateModel>(builder: (context, model, child) {
      return Scaffold(
          appBar: PreferredSize(
            child: AppBar(
              title: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tasks', style: Styles.appBarTitle),
                        logout.logoutBuilder()
                      ])),
              backgroundColor: Color(0xffffffff),
              brightness: Brightness.light,
            ),
            preferredSize: Size.fromHeight(80),
          ),
          bottomNavigationBar: BottomBar(selected: 'tasks'),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: getFab(),
          body: Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CupertinoSlidingSegmentedControl(
                        groupValue: this.selected,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        children: tabs,
                        onValueChanged: (newRange) {
                          setState(() {
                            this.selected = newRange;
                          });
                        })),
                if (selected == 'category')
                  TasksByCategory()
                else
                  TasksByDate(),
              ])));
    });
  }
}
