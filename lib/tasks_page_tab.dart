import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'task_row_item.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        final tasks = model.getProducts();
        return CustomScrollView(
          semanticChildCount: tasks.length,
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Tasks'),
            ),
            SliverSafeArea(
                top: false,
                minimum: const EdgeInsets.only(top: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < tasks.length) {
                        return TaskRowItem(
                          index: index,
                          task: tasks[index],
                          lastItem: index == tasks.length - 1,
                        );
                      }
                      return null;
                    }
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}