import 'package:flutter/cupertino.dart';

class MineTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Mine'),
        ),
      ],
    );
  }
}
