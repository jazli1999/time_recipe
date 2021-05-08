import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/models/repository.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/styles.dart';

class CategoryDistributionCard extends StatefulWidget {
  CategoryDistributionCard({this.orientation});

  final Orientation orientation;

  @override
  State<StatefulWidget> createState() {
    return _CategoryDistributionCardState();
  }
}

final List<Color> colors = [
  Color(0xbba05195),
  Color(0xbbd45087),
  Color(0xbbf95d6a),
  Color(0xbbff7c43),
  Color(0xbbffa600),
];

class _CategoryDistributionCardState extends State<CategoryDistributionCard> {
  List<PieChartSectionData> sectionData = [];
  int counter;
  bool updated = false;
  List<String> percentages = [];

  void _updateData() async {
    if (Repository.categories == null) await Repository.updateCategories();
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
                titleStyle: Styles.thirdFontBoldWhite,
                radius: 70,
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

  Widget _portraitBuilder() {
    return Container(
        constraints: BoxConstraints(minWidth: 400, maxHeight: 320),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: 15),
          Text('Tasks Distribution by Category', style: Styles.baseFontBold),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              constraints: BoxConstraints(
                  minWidth: 220, minHeight: 220, maxWidth: 220, maxHeight: 220),
              child: this.sectionData.length == 0
                  ? Text('No data')
                  : PieChart(PieChartData(
                      sections: this.sectionData,
                      centerSpaceRadius: 30,
                      sectionsSpace: 3,
                      borderData: FlBorderData(
                        show: false,
                      ),
                    )),
            ),
            SizedBox(width: 10),
            if (updated) _CategoryLegend(),
          ])
        ]));
  }

  Widget _landscapeBuilder() {
    return Container(
        constraints: BoxConstraints(minWidth: 400, maxHeight: 550),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: 15),
          Text('Tasks Distribution by Category', style: Styles.baseFontBold),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              children: [
                SizedBox(height: 15),
                Container(
                  constraints: BoxConstraints(
                      minWidth: 220,
                      minHeight: 220,
                      maxWidth: 220,
                      maxHeight: 220),
                  child: this.sectionData.length == 0
                      ? Text('No data')
                      : PieChart(PieChartData(
                          sections: this.sectionData,
                          centerSpaceRadius: 30,
                          sectionsSpace: 3,
                          borderData: FlBorderData(
                            show: false,
                          ),
                        )),
                ),
                SizedBox(height: 20),
                if (updated) _CategoryLegend(),
              ],
            )
          ])
        ]));
  }

  @override
  Widget build(BuildContext context) {
    this.counter = -1;
    if (!updated) _updateData();
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        shadowColor: Color(0x55000000),
        child: widget.orientation == Orientation.landscape &&
                MediaQuery.of(context).size.width > 800
            ? _landscapeBuilder()
            : _portraitBuilder());
  }
}

class Badge extends StatelessWidget {
  const Badge({this.icon, this.index});

  final String icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = 30.0;
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
          child: Center(child: Text(icon, style: Styles.secondFont)),
        ));
  }
}

class _CategoryLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _categoryLegendsBuilder());
  }

  List<Widget> _categoryLegendsBuilder() {
    List<Widget> rows = [];
    for (Category cat in Repository.categories) {
      rows.add(Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 30, child: Text(cat.icon, style: Styles.secondFont)),
              SizedBox(
                  width: 100,
                  child: Text(
                    cat.name,
                    style: Styles.secondFont,
                    softWrap: true,
                    maxLines: 3,
                  ))
            ],
          )));
    }
    return rows;
  }
}
