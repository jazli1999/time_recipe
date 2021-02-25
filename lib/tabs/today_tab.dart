import 'package:flutter/cupertino.dart';

class TodayTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Today'),
        ),
      ],
    );
  }
}
