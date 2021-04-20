import 'package:flutter/material.dart';
import 'package:emoji_chooser/emoji_chooser.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:time_recipe/db_connect.dart';

import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/current_user.dart';
import 'package:time_recipe/models/repository.dart';

class CategoryDetailCard extends StatefulWidget {
  CategoryDetailCard({@required this.isNew, @required this.category});
  final bool isNew;
  final Category category;

  @override
  State<StatefulWidget> createState() {
    return _CategoryDetailCardState();
  }
}

class _CategoryDetailCardState extends State<CategoryDetailCard> {
  String categoryName;
  String icon = '📂';
  bool updated = false;
  TextField nameField;

  void _openEmojiKeyboard() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
              height: 370,
              child: EmojiChooser(
                  columns: 8,
                  onSelected: (emoji) {
                    setState(() {
                      this.icon = emoji.char;
                    });
                  }));
        });
  }

  Widget _titleBuilder() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(widget.isNew ? 'Create New Category' : 'Edit Category',
          style: Styles.headerFont)
    ]);
  }

  Widget _iconPicker() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('Category Icon', style: Styles.baseFont),
      InkWell(
          onTap: this._openEmojiKeyboard,
          child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(5),
              dashPattern: [6],
              color: Colors.grey[600],
              strokeWidth: 2,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: Text(this.icon, style: Styles.headerFont))))
    ]);
  }

  Widget _categoryNameFieldBuilder() {
    FocusNode focusNode = new FocusNode();
    TextEditingController controller = new TextEditingController(
      text: categoryName,
    );
    nameField = TextField(
        focusNode: focusNode
          ..addListener(() {
            if (!focusNode.hasFocus) {
              categoryName = controller.text;
            }
          }),
        textAlign: TextAlign.start,
        style: Styles.baseFont,
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Tap to input the category title',
          contentPadding: EdgeInsets.only(bottom: -10, left: 5),
        ));
    return Row(children: [SizedBox(width: 300, child: nameField)]);
  }

  Widget _updateButtonBuilder() {
    return FloatingActionButton.extended(
        label: Text('Update'),
        backgroundColor: Colors.blue[600],
        icon: Icon(Icons.check),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          this.categoryName = nameField.controller.text;
          Map<String, dynamic> params = new Map();
          params['icon'] = this.icon;
          params['c_name'] = this.categoryName;
          params['c_id'] = widget.category.id;
          DBConnect.updateCategory(params).then((value) {
            if (value) {
              Navigator.pop(context);
              Repository.updateCategories();
            }
          });
        });
  }

  Widget _submitButtonBuilder() {
    return FloatingActionButton.extended(
        label: Text('Add'),
        backgroundColor: Colors.green,
        icon: Icon(Icons.check),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          this.categoryName = nameField.controller.text;
          Map<String, dynamic> params = new Map();
          params['icon'] = this.icon;
          params['c_name'] = this.categoryName;
          params['u_id'] = CurrentUser.getId();
          DBConnect.addCategory(params).then((value) {
            if (value) {
              Navigator.pop(context);
              Repository.updateCategories();
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    if (!updated) {
      if (widget.category.icon != null) this.icon = widget.category.icon;
      if (widget.category.name != null) categoryName = widget.category.name;
      this.updated = true;
    }

    return Container(
        constraints: BoxConstraints(maxHeight: 250),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(children: [
              _titleBuilder(),
              Divider(color: Colors.grey[400], thickness: 1),
              SizedBox(height: 15),
              _iconPicker(),
              _categoryNameFieldBuilder(),
              SizedBox(height: 20),
              if (widget.isNew)
                _submitButtonBuilder()
              else
                _updateButtonBuilder()
            ])));
  }
}
