import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_recipe/category_row_item.dart';

import 'package:time_recipe/models/app_state_model.dart';
import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/task_row_item.dart';

class TasksTab extends StatelessWidget {
  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
      List<Category> categories, AppStateModel model) {
    return SliverChildBuilderDelegate((context, index) {
      if (index < categories.length)
        return CategoryRowItem(
          category: categories[index],
          index: index,
          nextTask: model.calcNextTask(index),
        );
      else if (index == categories.length) {
        return TaskRowItem(
            dateTime: DateTime.now(),
            name: 'Chapter 4',
            isFirst: false,
            isLast: false);
      } else
        return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(builder: (context, model, child) {
      final categories = model.getAllCategories();
      return CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('Tasks'),
          ),
          SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 4),
              sliver: SliverList(
                delegate: _buildSliverChildBuilderDelegate(categories, model),
              ))
          // )
        ],
      );
    });
  }
}
