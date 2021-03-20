import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jiffy/jiffy.dart';
import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/models/repository.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/styles.dart';

class CategoryDistributionCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryDistributionCardState();
  }
}

class _CategoryDistributionCardState extends State<CategoryDistributionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        shadowColor: Color(0x55000000),
        child: Container(
          constraints: BoxConstraints(minWidth: 400),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text('Category Distribution Card',
                  style: Styles.secondFontBold)),
        ));
  }
}
