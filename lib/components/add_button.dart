import 'package:flutter/material.dart';

import 'package:time_recipe/components/category_detail_card.dart';
import 'package:time_recipe/models/category.dart';

AddButton button;

AddButton getFab() {
  if (button == null) button = AddButton();
  return button;
}

class AddButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddButtonState();
  }
}

class _AddButtonState extends State<AddButton> {
  bool _listShow = false;
  OverlayEntry _listEntry;
  Widget miniButtons;

  Widget _getMiniButtons() {
    if (miniButtons == null)
      miniButtons = Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 105),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                FloatingActionButton.extended(
                    label: Text('New Category'),
                    backgroundColor: Colors.blue[400],
                    icon: Icon(Icons.book_outlined),
                    onPressed: () {
                      toggleOverlay();
                      showDialog<Null>(
                          context: context,
                          builder: (BuildContext context) {
                            return UnconstrainedBox(
                                child: SizedBox(
                                    width: 450,
                                    child: Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: CategoryDetailCard(
                                          category: Category(),
                                          isNew: true,
                                          editMode: false),
                                    )));
                          });
                    }),
                SizedBox(height: 10),
                FloatingActionButton.extended(
                    label: Text('New Task'),
                    backgroundColor: Colors.blue[400],
                    icon: Icon(Icons.check_circle_outline),
                    onPressed: () {
                      toggleOverlay();
                      Navigator.pushNamed(context, '/addTask');
                    }),
              ])
            ]),
        SizedBox(height: 100),
      ]);
    return miniButtons;
  }

  void toggleOverlay() {
    if (_listShow) {
      _listEntry.remove();
      _listEntry = null;
      _listShow = false;
    } else {
      _listEntry = new OverlayEntry(builder: (context) {
        return _getMiniButtons();
      });
      Overlay.of(context).insert(_listEntry);
      _listShow = true;
    }
  }

  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 60,
        child: FloatingActionButton(
            child: Icon(Icons.add, size: 30),
            onPressed: () {
              toggleOverlay();
            }));
  }
}
