import 'package:flutter/cupertino.dart';

class TodayPage extends StatefulWidget {
  @override
  _SearchTabState createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: const <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Today'),
        ),
      ],
    );
  }
}