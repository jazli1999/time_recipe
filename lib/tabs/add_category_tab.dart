import 'package:flutter/material.dart';

import 'package:time_recipe/styles.dart';

class AddCategoryTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddCategoryTabState();
  }
}

class _AddCategoryTabState extends State<AddCategoryTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            title: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text('New Category', style: Styles.headerFont)),
            backgroundColor: Color(0xffffffff),
            brightness: Brightness.light,
          ),
          preferredSize: Size.fromHeight(80),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
            label: Text('Add'),
            icon: Icon(Icons.done),
            onPressed: () {},
            backgroundColor: Colors.green[500]),
        body: Text('add category'));
  }
}
