import 'package:flutter/rendering.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter/material.dart';

import 'package:time_recipe/styles.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/models/task.dart';
import 'package:time_recipe/components/builders.dart';

class TasksByDate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TasksByDateState();
  }
}

class _TasksByDateState extends State<TasksByDate> {
  DateTime selectedDate = DateTime.now();
  List<Task> tasks = [];
  bool updated = false;
  DateTime dateTime = DateTime.now();

  Widget _calendarBuilder() {
    //TODO collapsable
    return CalendarCarousel<Event>(
      height: 340,
      width: 350,
      dayPadding: 0,
      onDayPressed: (date, events) {
        this.selectedDate = date;
        this.updated = false;
        _updateData();
      },
      headerMargin: EdgeInsets.only(bottom: 5),
      headerTextStyle: TextStyle(
          fontSize: 14, color: Color(0xff448aff), fontWeight: FontWeight.bold),
      weekdayTextStyle:
          TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      weekendTextStyle:
          TextStyle(color: Styles.DARK_PURPLE, fontWeight: FontWeight.w500),
    );
  }

  Widget _dayLineBuilder() {
    Builders builders =
        new Builders(list: this.tasks, updateData: this._updateData);
    if (tasks.isEmpty) {
      return SizedBox(
          height: 150,
          width: 400,
          child: Center(child: Text('No Task This Day')));
    }
    return SizedBox(
        height: 150,
        width: 400,
        child: ListView.builder(
            itemCount: tasks.length,
            shrinkWrap: true,
            itemBuilder: builders.itemLineBuilder));
  }

  void _updateData() async {
    DBConnect.getDayTasksByUID(this.selectedDate).then((value) {
      setState(() {
        this.tasks = [];
        for (Object obj in value) {
          tasks.add(obj);
        }
        this.updated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!updated) _updateData();
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    children: [_calendarBuilder(), _dayLineBuilder()],
                  )
                ]))));
  }
}
