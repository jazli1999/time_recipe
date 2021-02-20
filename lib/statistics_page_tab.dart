import 'package:flutter/cupertino.dart';

class StatisticsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
      // TODO: implement createState
      return _StatisticsPageState();
    }
}

class _StatisticsPageState extends State<StatisticsPage> {
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