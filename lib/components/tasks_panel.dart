import 'package:flutter/material.dart';
import 'package:time_recipe/components/task_row_item.dart';
import 'package:time_recipe/models/task.dart';
import 'package:time_recipe/db_connect.dart';

class TasksPanel extends StatefulWidget {
  const TasksPanel({@required this.categoryId});

  final int categoryId;

  @override
  State<StatefulWidget> createState() {
    return _TasksPanelState(categoryId: categoryId);
  }
}

class _TasksPanelState extends State<TasksPanel> {
  _TasksPanelState({@required this.categoryId});

  final int categoryId;
  List<Task> tasks = <Task>[];
  bool updated = false;

  void _updateData() async {
    DBConnect.getTasksByCID(categoryId).then((value) {
      if (mounted) {
        setState(() {
          this.tasks = [];
          for (Object task in value) {
            this.tasks.add(task);
          }
          this.updated = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!updated) _updateData();
    return Container(
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            color: Color(0xfff5f5f5)),
        child: Column(children: <Widget>[
          Container(
              constraints: BoxConstraints(maxHeight: 1),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 12, color: Color(0xff808080))
              ])),
          SafeArea(
              left: false,
              right: false,
              minimum: EdgeInsets.only(bottom: 20, top: 20),
              child: ListView.builder(
                itemCount: tasks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (tasks.length == 1) {
                    if (index == 0)
                      return TaskRowItem(
                          isFirst: true,
                          isLast: true,
                          task: tasks[index],
                          refreshData: _updateData);
                    else
                      return null;
                  } else {
                    if (index == 0)
                      return TaskRowItem(
                          isFirst: true,
                          isLast: false,
                          task: tasks[index],
                          refreshData: _updateData);
                    else if (index < tasks.length - 1)
                      return TaskRowItem(
                          isFirst: false,
                          isLast: false,
                          task: tasks[index],
                          refreshData: _updateData);
                    else if (index == tasks.length - 1)
                      return TaskRowItem(
                          isFirst: false,
                          isLast: true,
                          task: tasks[index],
                          refreshData: _updateData);
                    else
                      return null;
                  }
                },
              ))
        ]));
  }
}
