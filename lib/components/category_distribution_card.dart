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

final List<Color> colors = [
  Color(0xD9a05195),
  Color(0xD9d45087),
  Color(0xD9f95d6a),
  Color(0xD9ff7c43),
  Color(0xD9ffa600),
];

class _CategoryDistributionCardState extends State<CategoryDistributionCard> {
  List<PieChartSectionData> sectionData = [];
  int counter;
  bool updated = false;
  List<String> percentages = [];

  void _updateData() async {
    await Repository.updateCategories();
    DBConnect.getTasksDistributionByCategory().then((results) {
      setState(() {
        this.sectionData = [];
        _calcPercentage(results);
        if (results.isNotEmpty) {
          results.forEach((key, value) {
            counter += 1;
            Category cat = Repository.getCategoryById(int.parse(key));
            this.sectionData.add(PieChartSectionData(
                value: double.parse(value),
                title: percentages[counter],
                radius: 80,
                color: colors[counter % 5],
                badgePositionPercentageOffset: 0.98,
                badgeWidget: Badge(icon: cat.icon, index: counter)));
          });
        }
        updated = true;
      });
    });
  }

  void _calcPercentage(Map<String, dynamic> data) {
    double sum = 0;
    data.forEach((id, count) {
      sum += double.parse(count);
    });
    this.percentages = [];
    data.forEach((id, count) {
      percentages
          .add((double.parse(count) / sum * 100).round().toString() + '%');
    });
  }

  @override
  Widget build(BuildContext context) {
    this.counter = -1;
    if (!updated) _updateData();
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        shadowColor: Color(0x55000000),
        child: Container(
            constraints: BoxConstraints(
                minWidth: 400, minHeight: 400, maxWidth: 400, maxHeight: 400),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: this.sectionData.length == 0
                  ? Text('No data')
                  : PieChart(PieChartData(
                      sections: this.sectionData,
                      centerSpaceRadius: 50,
                      sectionsSpace: 5,
                      borderData: FlBorderData(
                        show: false,
                      ),
                    )),
            )));
  }
}

class Badge extends StatelessWidget {
  const Badge({this.icon, this.index});

  final String icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = 40.0;
    return SizedBox(
        height: size,
        width: size,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: colors[index % 5], width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.5),
                offset: const Offset(3, 3),
                blurRadius: 3,
              )
            ],
          ),
          child: Center(child: Text(icon, style: Styles.baseFont)),
        ));
  }
}
