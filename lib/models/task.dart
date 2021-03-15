import 'package:flutter/foundation.dart';

class Task {
  Task(
      {@required this.name,
      @required this.dateTime,
      @required this.isDone,
      @required this.categoryId,
      @required this.id,
      this.note})
      : assert(name != null),
        assert(dateTime != null),
        assert(isDone != null),
        assert(id != null);

  final String name;
  final DateTime dateTime;
  final bool isDone;
  final int categoryId;
  final int id;
  String note;

  static Task fromJson(Map<String, dynamic> jsonObj) {
    return new Task(
      name: jsonObj['t_name'],
      id: int.parse(jsonObj['id']),
      categoryId: int.parse(jsonObj['c_id']),
      dateTime: DateTime.parse(jsonObj['date_time']),
      isDone: jsonObj['is_done'] != "0",
    );
  }
}
