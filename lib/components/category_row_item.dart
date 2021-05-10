import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:time_recipe/components/category_detail_card.dart';
import 'dart:ui';

import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/components/tasks_panel.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/models/repository.dart';

class CategoryRowItem extends StatefulWidget {
  const CategoryRowItem({this.index, this.category, this.nextTask});

  final Category category;
  final int index;
  final String nextTask;

  @override
  State<StatefulWidget> createState() {
    return _CategoryRowItemState();
  }
}

class _CategoryRowItemState extends State<CategoryRowItem> {
  bool showButtons = false;

  void _deleteCategory() {
    DBConnect.deleteCategoryById(widget.category.id).then((value) {
      if (value) {
        setState(() {
          this.showButtons = false;
          Repository.updateCategories();
        });
      }
    });
  }

  void _editCategory() {
    showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return UnconstrainedBox(
              child: SizedBox(
                  width: 450,
                  child: Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: CategoryDetailCard(
                          category: widget.category, isNew: false))));
        }).then((_) {
      setState(() {
        this.showButtons = false;
        Repository.updateCategories();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final row = GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < 0) {
            setState(() {
              this.showButtons = true;
            });
          } else {
            setState(() {
              this.showButtons = false;
            });
          }
        },
        child: Card(
          elevation: 5,
          shadowColor: Color(0x44000000),
          margin: EdgeInsets.symmetric(
              horizontal: 12, vertical: 6), // margins from the device screen
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ExpansionCard(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              title: Stack(children: [
                SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(
                                    right:
                                        10), // gap between the icon and the category name
                                child: Text(
                                  widget.category.icon,
                                  style: Styles.baseFont,
                                )),
                            Text(
                              widget.category.name,
                              style: Styles.baseFont,
                            ),
                          ],
                        ),
                        Text(
                          widget.nextTask,
                          style: Styles.categoryNextTask,
                        )
                      ],
                    )),
                if (showButtons)
                  ClipRect(
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Padding(
                                        padding: EdgeInsets.all(7),
                                        // padding to display the fab shadows
                                        child: FloatingActionButton(
                                            backgroundColor: Styles.PURPLE,
                                            onPressed: this._editCategory,
                                            elevation: 5,
                                            child: Icon(
                                              Icons.edit,
                                              size: 25,
                                            )))),
                                SizedBox(
                                  width: 15,
                                ),
                                SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Padding(
                                        padding: EdgeInsets.all(7),
                                        // padding to display the fab shadows
                                        child: FloatingActionButton(
                                            backgroundColor: Colors.red[600],
                                            onPressed: this._deleteCategory,
                                            elevation: 5,
                                            child: Icon(
                                              Icons.delete_outlined,
                                              size: 25,
                                            ))))
                              ])))
              ]),
              children: <Widget>[
                TasksPanel(
                  categoryId: widget.category.id,
                )
              ]),
        ));
    return row;
  }
}
