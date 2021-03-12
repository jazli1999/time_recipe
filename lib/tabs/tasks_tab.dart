import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_recipe/Components/category_row_item.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/models/app_state_model.dart';

class TasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(builder: (context, model, child) {
      final categories = model.getAllCategories();
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
          body: ListView.builder(
            itemCount: categories.length,
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
