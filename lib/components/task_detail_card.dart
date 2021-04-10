import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:time_recipe/models/task.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/utils.dart';

class TaskDetailCard extends StatefulWidget {
  const TaskDetailCard({this.task, this.categoryHeader, this.isNew = false});
  final Task task;
  final String categoryHeader;
  final bool isNew;

  @override
  State<StatefulWidget> createState() {
    return _TaskDetailCardState(task: task, categoryHeader: categoryHeader);
  }
}

class _TaskDetailCardState extends State<TaskDetailCard> {
  _TaskDetailCardState({this.task, this.categoryHeader})
      : date = task.dateTime,
        time = task.dateTime,
        taskName = task.name;
  final Task task;
  Task newTask;
  List<Category> categories = [];
  Map<String, int> catHeaderId = new Map();

  String categoryHeader;
  DateTime date;
  DateTime time;
  int categoryId;
  String taskName;
  bool editMode = false;
  bool updated = false;

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
            enabled: widget.isNew || this.editMode,
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
                      if (widget.isNew || editMode)
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
                  if (widget.isNew || editMode)
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
    if (categoryHeader == null) {
      categoryHeader = Utils.getCategoryHeader(this.categories[0]);
    }
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _labelBuilder('📂', 'Category'),
            if (widget.isNew || editMode)
              DropdownButton<String>(
                icon: Icon(Icons.keyboard_arrow_down),
                style: Styles.thirdFont,
                value: categoryHeader == null ? ' ' : categoryHeader,
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

  Widget _viewBtnRowBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
            color: Color(0xbb845ba8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {
              Map<String, dynamic> params = new Map();
              params['id'] = task.id;
              params['is_done'] = 1;
              DBConnect.updateTaskByTID(params).then((value) {
                if (value) {
                  Navigator.pop(context);
                }
              });
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
          onPressed: () {
            Map<String, dynamic> params = new Map();
            params['id'] = task.id;
            DateTime dateTime = DateTime(
                date.year, date.month, date.day, time.hour, time.minute);
            params['date_time'] = dateTime.toString();
            params['c_id'] = categoryId;
            params['t_name'] = taskName;
            DBConnect.updateTaskByTID(params).then((value) {
              if (value) {
                Navigator.pop(context);
              }
            });
          },
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
          onPressed: () {
            DBConnect.deleteTaskByTID(task.id).then((value) {
              if (value) {
                Navigator.pop(context);
              }
            });
          },
        ),
      ],
    );
  }

  Widget _cardWrapper(Widget _child) {
    return UnconstrainedBox(
        child: SizedBox(
            width: 460,
            child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: _child)));
  }

  Widget _contentBuilder() {
    return Container(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                if (!widget.isNew && !editMode) _editBtn(),
                _taskNameFieldBuilder(),
                _categoryRowBuilder(),
                _dateRowBuilder(),
                _timeRowBuilder(),
                if (!widget.isNew && editMode)
                  _editBtnRowBuilder()
                else if (!widget.isNew)
                  _viewBtnRowBuilder(),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (!updated) _fetchLatestCategories();

    if (widget.isNew)
      return _cardWrapper(_contentBuilder());
    else
      return _contentBuilder();
  }
}

class _CIdHeader {
  const _CIdHeader({@required this.id, @required this.header});

  final int id;
  final String header;
}
