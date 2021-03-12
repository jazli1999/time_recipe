import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import 'models/app_state_model.dart';
import 'styles.dart';

class TaskRowItem extends StatelessWidget {
  const TaskRowItem({this.dateTime, this.name, this.isFirst, this.isLast});

  final DateTime dateTime;
  final String name;
  final bool isFirst;
  final bool isLast;

  final weekdays = const [
    'Mon.',
    'Tues',
    'Wedns',
    'Thurs',
    'Fri',
    'Sat.',
    'Sun'
  ];

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
                thickness: 2,
              )))
    ]);
  }

  Widget _rowContentBuilder() {
    final dateString = getDateString(this.dateTime);
    return Row(
      children: [
        Container(
          alignment: Alignment.centerRight,
          constraints: BoxConstraints(
              minHeight: 20, maxHeight: 20, minWidth: 80, maxWidth: 80),
          child: Text(dateString,
              style: dateString == 'Today'
                  ? Styles.baseFontBold
                  : Styles.baseFont),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          constraints: BoxConstraints(
              minWidth: 20, minHeight: 20, maxHeight: 20, maxWidth: 20),
          decoration: BoxDecoration(
            color: Color(0xff64a7f2),
            border: Border.all(color: Color(0xffffffff), width: 4.5),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Color(0x55000000),
                  offset: Offset(0.0, 3.0),
                  spreadRadius: -3,
                  blurRadius: 10)
            ],
          ),
        )
      ],
    );
  }

  Widget _firstRowBuilder() {
    final row = SafeArea(
        top: false,
        bottom: false,
        minimum: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 8,
          bottom: 8,
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(children: <Widget>[
              _rowContentBuilder(),
              _lineBuilder(),
            ])));
    return row;
  }

  Widget _onlyRowBuilder() {
    final row = SafeArea(
        top: false,
        bottom: false,
        minimum: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 8,
          bottom: 8,
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(children: <Widget>[
              _rowContentBuilder(),
            ])));
    return row;
  }

  Widget _midRowBuilder() {
    final row = SafeArea(
        top: false,
        bottom: false,
        minimum: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 8,
          bottom: 8,
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(children: <Widget>[
              _lineBuilder(),
              _rowContentBuilder(),
              _lineBuilder(),
            ])));
    return row;
  }

  Widget _lastRowBuilder() {
    final row = SafeArea(
        top: false,
        bottom: false,
        minimum: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 8,
          bottom: 8,
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(children: <Widget>[
              _lineBuilder(),
              _rowContentBuilder(),
            ])));
    return row;
  }

  @override
  Widget build(BuildContext context) {
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
