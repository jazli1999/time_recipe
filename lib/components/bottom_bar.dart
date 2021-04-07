import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  BottomBar({@required this.selected});

  final String selected;

  @override
  State<StatefulWidget> createState() {
    return _BottomBarState();
  }
}

class _BottomBarState extends State<BottomBar> {
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
                    color: widget.selected == "tasks"
                        ? Colors.blue[600]
                        : Colors.grey[600]),
                onPressed: () {
                  Navigator.pushNamed(context, '/tasks');
                }),
            Spacer(flex: 2),
            IconButton(
                icon: Icon(Icons.pie_chart_outline_rounded,
                    size: 30,
                    color: widget.selected == "statistics"
                        ? Colors.blue[600]
                        : Colors.grey[600]),
                onPressed: () {
                  Navigator.pushNamed(context, '/statistics');
                }),
            Spacer(flex: 1),
          ]),
        ));
  }
}
