import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:time_recipe/models/task.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/utils.dart';

class TaskDetail extends StatefulWidget {
  TaskDetail(
      {@required this.editMode,
      @required this.categoryHeader,
      @required this.task});

  final bool editMode;
  final String categoryHeader;
  final Task task;

  @override
  State<StatefulWidget> createState() {
    return _TaskDetailState();
  }
}

class _TaskDetailState extends State<TaskDetail> {
  String taskName;
  DateTime date;
  DateTime time;
  String categoryHeader;
  List<Category> categories = [];
  bool updated = false;
  int categoryId;
  Map<String, int> catHeaderId = new Map();

  Widget _taskNameFieldBuilder() {
    FocusNode focusNode = new FocusNode();
    TextEditingController controller = new TextEditingController(
      text: taskName,
    );
    return Row(children: [
      SizedBox(
        width: 330,
        child: TextField(
            focusNode: focusNode
              ..addListener(() {
                if (!focusNode.hasFocus) {
                  taskName = controller.text;
                }
              }),
            textAlign: TextAlign.start,
            style: Styles.baseFontBold,
            enabled: widget.editMode,
            controller: controller,
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
                      if (widget.editMode)
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
                  if (widget.editMode)
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
            if (widget.editMode)
              DropdownButton<String>(
                icon: Icon(Icons.keyboard_arrow_down),
                style: Styles.thirdFont,
                value: widget.categoryHeader == null ? ' ' : categoryHeader,
                items: _getAllCategoryHeaders()
                    .map<DropdownMenuItem<String>>((_CIdHeader value) {
                  return DropdownMenuItem<String>(
                    value: value.header,
                    child: Text(value.header),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  if (mounted)
                    setState(() {
                      this.categoryHeader = newValue;
                      this.categoryId = catHeaderId[newValue];
                    });
                },
              )
            else
              Text(categoryHeader, style: Styles.thirdFont)
          ],
        ));
  }

  List<_CIdHeader> _getAllCategoryHeaders() {
    List<_CIdHeader> headers = [];
    catHeaderId = new Map();
    for (Category cat in categories) {
      String header = Utils.getCategoryHeader(cat);
      headers.add(new _CIdHeader(id: cat.id, header: header));
      catHeaderId[header] = cat.id;
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
          this.updated = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!updated) _fetchLatestCategories();
    date = widget.task.dateTime;
    time = widget.task.dateTime;
    taskName = widget.task.name;

    return Container(
        constraints: BoxConstraints(maxHeight: 400),
        child: Column(children: [
          _taskNameFieldBuilder(),
          _categoryRowBuilder(),
          _dateRowBuilder(),
          _timeRowBuilder(),
        ]));
  }
}

class _CIdHeader {
  const _CIdHeader({@required this.id, @required this.header});

  final int id;
  final String header;
}
