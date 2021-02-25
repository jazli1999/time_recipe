import 'package:flutter/foundation.dart';

import 'task.dart';

class Category {
  const Category({
    @required this.name,
    @required this.tasks,
    @required this.isArchived,
    @required this.id,
  });

  final String name;
  final List<Task> tasks;
  final bool isArchived;
  final int id;
}
