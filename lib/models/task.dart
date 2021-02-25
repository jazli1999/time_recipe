import 'package:flutter/foundation.dart';

class Task {
  const Task(
      {@required this.name,
      @required this.dateTime,
      @required this.isDone,
      @required this.id})
      : assert(name != null),
        assert(dateTime != null),
        assert(isDone != null),
        assert(id != null);

  final String name;
  final DateTime dateTime;
  final bool isDone;
  final int id;
}
