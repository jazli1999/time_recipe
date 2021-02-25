import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';

// import 'models/app_state_model.dart';
import 'models/category.dart';
import 'styles.dart';

class CategoryRowItem extends StatelessWidget {
  const CategoryRowItem({
    this.index,
    this.category,
    this.nextTask,
  });

  final Category category;
  final int index;
  final String nextTask;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
        top: false,
        bottom: false,
        minimum: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 8,
          bottom: 8,
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          category.icon,
                          style: Styles.baseFont,
                        )),
                    Text(
                      category.name,
                      style: Styles.baseFont,
                    ),
                  ],
                ),
                Text(
                  nextTask,
                  style: Styles.categoryNextTask,
                )
              ],
            )));
    return row;
  }
}
