import 'package:flutter/foundation.dart';

import 'task.dart';

class Category {
  const Category(
      {@required this.name,
      @required this.tasks,
      @required this.isArchived,
      @required this.id,
      @required this.icon})
      : assert(name != null),
        assert(tasks != null),
        assert(isArchived != null),
        assert(id != null),
        assert(icon != null);

  final String name;
  final List<Task> tasks;
  final bool isArchived;
  final int id;
  final String icon;
}
