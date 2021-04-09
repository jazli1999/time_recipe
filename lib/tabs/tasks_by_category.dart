import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/models/repository.dart';
import 'package:time_recipe/components/category_row_item.dart';
import 'package:time_recipe/utils.dart';

class TasksByCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TasksByCategoryState();
  }
}

class _TasksByCategoryState extends State<TasksByCategory> {
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
    if (!this.updated) _updateData();
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 230),
            child: ListView.builder(
              itemCount: this.categories.length,
              itemBuilder: (context, index) {
                return CategoryRowItem(
                  category: categories[index],
                  index: index,
                  nextTask: Utils.calcNextTask(index),
                );
              },
            )));
  }
}
