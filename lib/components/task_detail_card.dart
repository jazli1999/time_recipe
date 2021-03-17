import 'package:flutter/material.dart';

import 'package:time_recipe/models/task.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/utils.dart';

class TaskDetailCard extends StatefulWidget {
  const TaskDetailCard({this.task, this.categoryHeader});
  final Task task;
  final String categoryHeader;

  @override
  State<StatefulWidget> createState() {
    return _TaskDetailCardState(task: task, categoryHeader: categoryHeader);
  }
}

class _TaskDetailCardState extends State<TaskDetailCard> {
  _TaskDetailCardState({this.task, this.categoryHeader});
  final Task task;
  Task newTask;
  List<Category> categories = [];
  String categoryHeader;

  Widget _taskNameFieldBuilder() {
    return TextField(
        textAlign: TextAlign.start,
        style: Styles.baseFontBold,
        controller: TextEditingController(
          text: task?.name,
        ),
        decoration: InputDecoration(
          hintText: 'Task Title',
          contentPadding: EdgeInsets.only(bottom: -10),
        ));
  }

  Widget _categoryRowBuilder() {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('📂', style: Styles.secondFont),
                SizedBox(width: 7),
                Text('Category', style: Styles.secondFont),
              ],
            ),
            DropdownButton<String>(
              icon: Icon(Icons.keyboard_arrow_down),
              style: Styles.thirdFont,
              value: categoryHeader == null ? ' ' : categoryHeader,
              items: _getAllCategoryHeaders()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  this.categoryHeader = newValue;
                });
              },
            )
          ],
        ));
  }

  List<String> _getAllCategoryHeaders() {
    List<String> headers = [];
    for (Category cat in categories) {
      headers.add(Utils.getCategoryHeader(cat));
    }
    return headers;
  }

  void _fetchLatestCategories() async {
    DBConnect.getCategoriesByUID().then((value) {
      setState(() {
        this.categories = [];
        for (Object cat in value) {
          this.categories.add(cat);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _fetchLatestCategories();
    return Container(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                _taskNameFieldBuilder(),
                _categoryRowBuilder(),
              ],
            )));
  }
}
