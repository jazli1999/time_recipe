import 'package:flutter/cupertino.dart';

import 'package:time_recipe/category_row_item.dart';
import 'package:time_recipe/models/category.dart';

import 'package:time_recipe/models/app_state_model.dart';

class TasksTab extends StatelessWidget {
  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate((context, index) {
      switch (index) {
        case 0:
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CategoryRowItem(
              index: 1,
              category: Category(
                name: 'Assignment',
                tasks: List(),
                isArchived: false,
                id: 1,
                icon: '📚',
              ),
            ),
          );
        default:
          return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Tasks'),
        ),
        SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.only(top: 4),
            sliver: SliverList(
              delegate: _buildSliverChildBuilderDelegate(),
            ))
        // )
      ],
    );
  }
}
