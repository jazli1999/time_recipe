import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jiffy/jiffy.dart';
import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/models/repository.dart';
import 'package:time_recipe/db_connect.dart';

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
  double dateAxisMin = Jiffy(DateTime.now()).dayOfYear.toDouble();
  double dateAxisMax;
  bool updated = false;
  List<FlSpot> dots = [];

  final List<Color> colors = [
    Color(0xff2af598),
    Color(0xff009efd),
  ];

  List<LineChartBarData> lineData = [];
  LineChartBarData _dataLineBuilder(List<FlSpot> spots) {
    return LineChartBarData(
        spots: spots,
        isCurved: false,
        dotData: FlDotData(show: false),
        colors: colors,
        belowBarData: BarAreaData(
            show: true,
            colors: colors.map((color) => color.withOpacity(0.3)).toList()),
        barWidth: 2);
  }

  List<FlSpot> _spotBuilder(Map<String, dynamic> data) {
    dots = [];
    String endDate =
        _calcEndDate().subtract(Duration(days: 1)).toString().substring(0, 10);
    if (!data.containsKey(endDate)) data[endDate] = '0';
    data.forEach((key, value) {
      FlSpot spot = FlSpot(
          Jiffy(DateTime.parse(key)).dayOfYear.toDouble(), double.parse(value));
      dots.add(spot);
    });
    dots.sort((spot, nextSpot) => (spot.x - nextSpot.x).round());
    return dots;
  }

  double _calcNumAxisMax() {
    int max = 0;
    dots.forEach((dot) {
      if (dot.y > max) max = dot.y.ceil();
    });
    return (max + (5 - max % 5)).toDouble();
  }

  double _calcAxisInterval(double min, double max) {
    double interval = (max - min) / 6;
    return interval.abs().round().toDouble();
  }

  DateTime _calcEndDate() {
    DateTime today = DateTime.now();
    switch (widget.range) {
      case 'week':
        return today.add(Duration(days: 7));
      case 'month':
        int lastDay = DateTime(today.year, today.month + 2, 0).day;
        int day = today.day > lastDay ? lastDay : today.day;
        if (today.month == 12) return DateTime(today.year + 1, 1, day);
        return DateTime(today.year, today.month + 1, today.day);
      case 'months':
        int lastDay = DateTime(today.year, today.month + 4, 0).day;
        int day = today.day > lastDay ? lastDay : today.day;
        if (today.month > 9)
          return DateTime(today.year + 1, today.month - 9, day);
        return DateTime(today.year, today.month + 3, day);
      case 'year':
        int lastDay = DateTime(today.year + 1, today.month + 1, 0).day;
        int day = today.day > lastDay ? lastDay : today.day;
        return DateTime(today.year + 1, today.month, day);
      default:
        return today;
    }
  }

  void _updateData() {
    DateTime now = DateTime.now();
    DBConnect.getTasksDistributionByTime(
            DateTime(now.year, now.month, now.day, 0, 0, 0), _calcEndDate())
        .then((value) {
      if (mounted) {
        setState(() {
          this.lineData = [];
          List<FlSpot> spots = _spotBuilder(value);
          if (spots.isNotEmpty) this.lineData.add(_dataLineBuilder(spots));
        });
        updated = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateData();
    DateTime endTime = _calcEndDate();
    dateAxisMax = Jiffy(endTime).dayOfYear.toDouble();
    double numAxisMax = _calcNumAxisMax();
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        shadowColor: Color(0x55000000),
        child: Container(
            constraints: BoxConstraints(minWidth: 400),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(widget.range),
                  Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: this.lineData.isEmpty || this.lineData == null
                          ? Text('No data')
                          : LineChart(LineChartData(
                              minX: dateAxisMin,
                              maxX: dateAxisMax,
                              minY: 0,
                              maxY: numAxisMax,
                              lineBarsData: this.lineData,
                              gridData: FlGridData(
                                horizontalInterval:
                                    _calcAxisInterval(0, numAxisMax),
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: Border(
                                    left: BorderSide(
                                        width: 1, color: Color(0x55000000)),
                                    bottom: BorderSide(
                                        width: 1, color: Color(0x55000000))),
                              ),
                              titlesData: FlTitlesData(
                                  bottomTitles: SideTitles(
                                    getTitles: (value) {
                                      DateTime date = DateTime.now().add(
                                          Duration(
                                              days: (value - dateAxisMin)
                                                  .round()
                                                  .abs()));
                                      return '${date.month}.${date.day}';
                                    },
                                    showTitles: true,
                                    interval: _calcAxisInterval(
                                        dateAxisMin, dateAxisMax),
                                  ),
                                  leftTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      interval:
                                          _calcAxisInterval(0, numAxisMax)),
                                  rightTitles: SideTitles(
                                      getTextStyles: (_) =>
                                          TextStyle(color: Colors.white),
                                      showTitles: true,
                                      reservedSize: 30)),
                            )))
                ])));
  }
}
