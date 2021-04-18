import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import 'models/app_state_model.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/models/task.dart';
import 'package:time_recipe/components/task_detail_card.dart';
import 'package:time_recipe/utils.dart';

class TaskRowItem extends StatefulWidget {
  TaskRowItem(
      {@required this.task,
      @required this.isFirst,
      @required this.isLast,
      @required this.refreshData});

  final Task task;
  final bool isFirst;
  final bool isLast;
  final Function refreshData;

  @override
  State<StatefulWidget> createState() {
    return _TaskRowItemState(
        isFirst: isFirst, isLast: isLast, task: task, refreshData: refreshData);
  }
}

class _TaskRowItemState extends State<TaskRowItem> {
  _TaskRowItemState(
      {@required this.task,
      @required this.isFirst,
      @required this.isLast,
      @required this.refreshData});

  final Task task;
  final bool isFirst;
  final bool isLast;
  final Function refreshData;
  final weekdays = const ['Mon', 'Tues', 'Wedns', 'Thurs', 'Fri', 'Sat', 'Sun'];

  BuildContext context;

  String getDateString(DateTime dateTime) {
    final today = DateTime.now();
    if (dateTime.year == today.year &&
        dateTime.month == today.month &&
        dateTime.day == today.day) return 'Today';
    return this.weekdays[dateTime.weekday - 1] + '. ' + dateTime.day.toString();
  }

  Widget _lineBuilder() {
    return Row(children: <Widget>[
      Container(
          constraints: BoxConstraints(minHeight: 10, maxHeight: 10),
          child: Padding(
              padding: EdgeInsets.only(left: 105),
              child: VerticalDivider(
                color: Color(0xffb2b2b2),
                width: 10,
                thickness: 1.5,
              )))
    ]);
  }

  Widget _rowContentBuilder() {
    final dateString = getDateString(this.task.dateTime);
    final dotSize = dateString == 'Today' ? 20.0 : 16.0;
    return Row(
      children: [
        Container(
          alignment: Alignment.centerRight,
          constraints: BoxConstraints(
              minHeight: 20, maxHeight: 20, minWidth: 80, maxWidth: 80),
          child: Text(dateString,
              style: dateString == 'Today'
                  ? Styles.secondFontBold
                  : Styles.secondFont),
        ),
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: dateString == 'Today' ? 20 : 22),
          constraints: BoxConstraints(
            minWidth: dotSize,
            minHeight: dotSize,
            maxHeight: dotSize,
            maxWidth: dotSize,
          ),
          decoration: BoxDecoration(
            color:
                dateString == 'Today' ? Color(0xff64a7f2) : Color(0xffb5b5b5),
            border: Border.all(
                color: Color(0xffffffff),
                width: dateString == 'Today' ? 4.5 : 3),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: dateString == 'Today'
                      ? Color(0x88000000)
                      : Color(0x55000000),
                  offset: Offset(0.0, 0.0),
                  spreadRadius: dateString == 'Today' ? -3 : -2,
                  blurRadius: 10)
            ],
          ),
        ),
        InkWell(
            onTap: () {
              showDialog<Null>(
                  context: context,
                  builder: (BuildContext context) {
                    return UnconstrainedBox(
                        child: SizedBox(
                            width: 450,
                            child: Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: TaskDetailCard(
                                  task: this.task,
                                  categoryHeader: Utils.getCategoryHeader(
                                      Utils.findCategoryById(task.categoryId))),
                            )));
                  }).then((_) {
                refreshData();
              });
            },
            child: Text("${task.name}${task.isDone ? ' ✅' : ''}",
                style:
                    task.isDone ? Styles.finishedTaskFont : Styles.secondFont)),
      ],
    );
  }

  Widget _firstRowBuilder() {
    final row = Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: <Widget>[
          _rowContentBuilder(),
          _lineBuilder(),
        ]));
    return row;
  }

  Widget _onlyRowBuilder() {
    final row = Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: <Widget>[
          _rowContentBuilder(),
        ]));
    return row;
  }

  Widget _midRowBuilder() {
    final row = Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: <Widget>[
          _lineBuilder(),
          _rowContentBuilder(),
          _lineBuilder(),
        ]));
    return row;
  }

  Widget _lastRowBuilder() {
    final row = Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: <Widget>[
          _lineBuilder(),
          _rowContentBuilder(),
        ]));
    return row;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    if (isFirst && isLast)
      return _onlyRowBuilder();
    else if (isFirst)
      return _firstRowBuilder();
    else if (isLast)
      return _lastRowBuilder();
    else
      return _midRowBuilder();
  }
}
