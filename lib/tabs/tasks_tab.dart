import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_recipe/Components/category_row_item.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/models/app_state_model.dart';
import 'package:time_recipe/models/repository.dart';
import 'package:time_recipe/components/bottom_bar.dart';
import 'package:time_recipe/components/add_button.dart';

class TasksTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TasksTabState();
  }
}

class _TasksTabState extends State<TasksTab> {
  List<Category> categories = [];
  bool updated = false;

  void _updateData() async {
    DBConnect.getCategoriesByUID().then((value) {
      setState(() {
        this.categories = [];
        Repository.categories = [];
        for (Object cat in value) {
          this.categories.add(cat);
          Repository.categories.add(cat);
        }
        this.updated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!updated) _updateData();
    return Consumer<AppStateModel>(builder: (context, model, child) {
      return Scaffold(
          appBar: PreferredSize(
            child: AppBar(
              title: Padding(
                  padding: EdgeInsets.only(top: 30, left: 10),
                  child: Text('Tasks', style: Styles.appBarTitle)),
              backgroundColor: Color(0xffffffff),
              brightness: Brightness.light,
            ),
            preferredSize: Size.fromHeight(80),
          ),
          bottomNavigationBar: getBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: getFab(),
          body: ListView.builder(
            itemCount: this.categories.length,
            itemBuilder: (context, index) {
              return CategoryRowItem(
                category: categories[index],
                index: index,
                nextTask: model.calcNextTask(index),
              );
            },
          ));
    });
  }
}
