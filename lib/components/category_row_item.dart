import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
// import 'package:provider/provider.dart';

import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/models/task_repository.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/components/tasks_panel.dart';

class CategoryRowItem extends StatelessWidget {
  const CategoryRowItem({
    this.index,
    this.category,
    this.nextTask,
  });

  final Category category;
  final int index;
  final String nextTask;

  @override
  Widget build(BuildContext context) {
    final row = Card(
      elevation: 5,
      shadowColor: Color(0x44000000),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionCard(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        category.icon,
                        style: Styles.baseFont,
                      )),
                  Text(
                    category.name,
                    style: Styles.baseFont,
                  ),
                ],
              ),
              Text(
                nextTask,
                style: Styles.categoryNextTask,
              )
            ],
          ),
          children: <Widget>[TasksPanel(tasks: TaskRepository.loadTasks())]),
    );
    return row;
  }
}
