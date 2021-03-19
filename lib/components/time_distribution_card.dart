import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/models/repository.dart';

class TimeDistributionCard extends StatefulWidget {
  TimeDistributionCard({@required this.range});

  final String range;

  @override
  State<StatefulWidget> createState() {
    return new _TimeDistributionCardState();
  }
}

class _TimeDistributionCardState extends State<TimeDistributionCard> {
  bool isAll = true;
  List<Category> countedCats = Repository.categories;

  // TODO remove mock data
  final mockDataA = [FlSpot(0, 2), FlSpot(1, 5), FlSpot(2, 20), FlSpot(3, 2)];
  final mockDataB = [
    FlSpot(0, 20),
    FlSpot(1, 10),
    FlSpot(2, 15),
    FlSpot(3, 18)
  ];

  final colors = [
    Color(0xffA4A295),
    Color(0xff564c4d),
    Color(0xff967d79),
    Color(0xff715351),
    Color(0xff6c737b)
  ];

  int counter;
  LineChartBarData _dataLineBuilder(List<FlSpot> spots) {
    counter += 1;
    return LineChartBarData(
        spots: spots,
        isCurved: true,
        dotData: FlDotData(show: false),
        colors: [colors[counter % 5]],
        barWidth: 3);
  }

  DateTime _calcStartDate() {
    DateTime today = DateTime.now();
    switch (widget.range) {
      case 'week':
        return today.subtract(Duration(days: 7));
      case 'month':
        int lastDay = DateTime(today.year, today.month, 0).day;
        int day = today.day > lastDay ? lastDay : today.day;
        if (today.month == 1) return DateTime(today.year - 1, 12, day);
        return DateTime(today.year, today.month - 1, today.day);
      case 'months':
        int lastDay = DateTime(today.year, today.month - 2, 0).day;
        int day = today.day > lastDay ? lastDay : today.day;
        if (today.month < 4)
          return DateTime(today.year - 1, today.month + 9, day);
        return DateTime(today.year, today.month - 3, day);
      case 'year':
        int lastDay = DateTime(today.year - 1, today.month, 0).day;
        int day = today.day > lastDay ? lastDay : today.day;
        return DateTime(today.year - 1, today.month, day);
      default:
        return today;
    }
  }

  @override
  Widget build(BuildContext context) {
    counter = -1;
    DateTime startTime = _calcStartDate();
    print(startTime.toString());
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        shadowColor: Color(0x55000000),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // Text(widget.range),
          Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: LineChart(LineChartData(
                minX: 0,
                maxX: 3,
                minY: 0,
                maxY: 30,
                lineBarsData: [
                  _dataLineBuilder(mockDataA),
                  _dataLineBuilder(mockDataB),
                ],
                gridData: FlGridData(
                  horizontalInterval: 5,
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(width: 1, color: Color(0x55000000)),
                ),
                titlesData: FlTitlesData(
                    leftTitles: SideTitles(
                        showTitles: true, reservedSize: 30, interval: 5),
                    rightTitles: SideTitles(
                        getTextStyles: (_) => TextStyle(color: Colors.white),
                        showTitles: true,
                        reservedSize: 30,
                        interval: 5)),
              )))
        ]));
  }
}
