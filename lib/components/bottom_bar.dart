import 'package:flutter/material.dart';

BottomBar bottomBar;

BottomBar getBar() {
  if (bottomBar == null) bottomBar = BottomBar();
  return bottomBar;
}

class BottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomBarState();
  }
}

class _BottomBarState extends State<BottomBar> {
  String selected;

  void changeSelected(String value) {
    setState(() {
      this.selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 15,
        child: SizedBox(
          height: 60,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Spacer(flex: 1),
            IconButton(
                icon: Icon(Icons.format_list_bulleted,
                    size: 30,
                    color: this.selected == "tasks"
                        ? Colors.blue[600]
                        : Colors.grey[600]),
                onPressed: () {
                  changeSelected('tasks');
                  Navigator.pushNamed(context, '/tasks');
                }),
            Spacer(flex: 2),
            IconButton(
                icon: Icon(Icons.pie_chart_outline_rounded,
                    size: 30,
                    color: this.selected == "statistics"
                        ? Colors.blue[600]
                        : Colors.grey[600]),
                onPressed: () {
                  changeSelected('statistics');
                  Navigator.pushNamed(context, '/statistics');
                }),
            Spacer(flex: 1),
          ]),
        ));
  }
}
