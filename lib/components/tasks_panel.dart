import 'package:flutter/material.dart';
import 'package:time_recipe/models/task.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/components/builders.dart';

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
    Builders builders =
        new Builders(list: this.tasks, updateData: this._updateData);

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
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      constraints: BoxConstraints(maxHeight: 400),
                      child: ListView.builder(
                        itemCount: tasks.length,
                        shrinkWrap: true,
                        itemBuilder: builders.itemLineBuilder,
                      ))))
        ]));
  }
}
