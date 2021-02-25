import 'package:flutter/cupertino.dart';

class TasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Tasks'),
        ),
      ],
    );
  }
}
