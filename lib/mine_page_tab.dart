import 'package:flutter/cupertino.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
      // TODO: implement createState
      return _MinePageState();
    }
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: const <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Statistics'),
        ),
      ],
    );
  }
}