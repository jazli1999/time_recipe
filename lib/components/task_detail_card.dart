import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
  _TaskDetailCardState({this.task, this.categoryHeader})
      : date = task.dateTime,
        time = task.dateTime;
  final Task task;
  Task newTask;
  List<Category> categories = [];

  String categoryHeader;
  DateTime date;
  DateTime time;
  bool editMode = false;

  Widget _editBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
            width: 25,
            child: InkWell(
              onTap: () {
                if (mounted)
                  setState(() {
                    this.editMode = true;
                  });
              },
              child: Icon(Icons.edit, size: 16),
            ))
      ],
    );
  }

  Widget _taskNameFieldBuilder() {
    return Row(children: [
      SizedBox(
        width: 330,
        child: TextField(
            textAlign: TextAlign.start,
            style: Styles.baseFontBold,
            enabled: this.editMode,
            controller: TextEditingController(
              text: task?.name,
            ),
            decoration: InputDecoration(
              hintText: 'Task Title',
              contentPadding: EdgeInsets.only(bottom: -10, left: 5),
            )),
      )
    ]);
  }

  Widget _labelBuilder(String icon, String title) {
    return Row(children: [
      Text(icon, style: Styles.secondFont),
      SizedBox(width: 7),
      Text(title, style: Styles.secondFont),
    ]);
  }

  Widget _dateRowBuilder() {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _labelBuilder('📅', 'Date'),
              Container(
                child: GestureDetector(
                    onTap: () {
                      if (editMode)
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(2121, 3, 15),
                            onConfirm: (newDate) {
                          if (mounted) {
                            setState(() {
                              this.date = newDate;
                            });
                          }
                        }, locale: LocaleType.zh);
                    },
                    child: Text(Utils.dateFormatter(this.date),
                        style: Styles.thirdFont)),
              )
            ],
          ),
        ]));
  }

  Widget _timeRowBuilder() {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _labelBuilder('⏰', 'Time'),
              Container(
                  child: GestureDetector(
                onTap: () {
                  if (editMode)
                    DatePicker.showTimePicker(context,
                        showTitleActions: true,
                        showSecondsColumn: false, onConfirm: (newTime) {
                      if (mounted) {
                        setState(() {
                          this.time = newTime;
                        });
                      }
                    });
                },
                child: Text(Utils.timeFormatter(this.time),
                    style: Styles.thirdFont),
              ))
            ],
          ),
        ]));
  }

  Widget _categoryRowBuilder() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _labelBuilder('📂', 'Category'),
            if (editMode)
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
                  if (mounted)
                    setState(() {
                      this.categoryHeader = newValue;
                    });
                },
              )
            else
              Text(categoryHeader, style: Styles.thirdFont)
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
      if (mounted)
        setState(() {
          this.categories = [];
          for (Object cat in value) {
            this.categories.add(cat);
          }
        });
    });
  }

  Widget _viewBtnRowBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
            color: Color(0xbb845ba8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {
              print('Completed!');
            },
            child: Row(
              children: [
                Icon(Icons.check_box_outlined, color: Color(0xffffffff)),
                Text(' Task Completed!',
                    style: TextStyle(color: Color(0xffffffff))),
              ],
            ))
      ],
    );
  }

  Widget _editBtnRowBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          color: Color(0xff65a4f9),
          child: Row(
            children: [
              Icon(Icons.done, color: Color(0xffffffff)),
              Text(' Update', style: TextStyle(color: Color(0xffffffff))),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: () => print('done'),
        ),
        RaisedButton(
          color: Color(0xffe26d6d),
          child: Row(
            children: [
              Icon(Icons.delete_forever, color: Color(0xffffffff)),
              Text(' Delete', style: TextStyle(color: Color(0xffffffff))),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: () => print('Delete'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _fetchLatestCategories();
    return Container(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                if (!editMode) _editBtn(),
                _taskNameFieldBuilder(),
                _categoryRowBuilder(),
                _dateRowBuilder(),
                _timeRowBuilder(),
                if (editMode) _editBtnRowBuilder() else _viewBtnRowBuilder(),
              ],
            )));
  }
}
