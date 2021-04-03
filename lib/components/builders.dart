import 'package:flutter/material.dart';

import 'package:time_recipe/components/task_row_item.dart';

class Builders {
  Builders({@required this.list, @required this.updateData});

  final List<dynamic> list;
  final Function updateData;

  Widget itemLineBuilder(BuildContext context, int index) {
    if (list.length == 1) {
      if (index == 0)
        return TaskRowItem(
            isFirst: true,
            isLast: true,
            task: list[index],
            refreshData: updateData);
      else
        return null;
    } else {
      if (index == 0)
        return TaskRowItem(
            isFirst: true,
            isLast: false,
            task: list[index],
            refreshData: updateData);
      else if (index < list.length - 1)
        return TaskRowItem(
            isFirst: false,
            isLast: false,
            task: list[index],
            refreshData: updateData);
      else if (index == list.length - 1)
        return TaskRowItem(
            isFirst: false,
            isLast: true,
            task: list[index],
            refreshData: updateData);
      else
        return null;
    }
  }
}
