import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/models/app_state_model.dart';
import 'package:time_recipe/components/time_distribution_card.dart';

class StatisticsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatisticsTabState();
  }
}

class _StatisticsTabState extends State<StatisticsTab> {
  final List<String> segmentsTitle = ['week', 'month', 'months', 'year'];
  final tabs = {
    'week': Text('1 week'),
    'month': Text('1 month'),
    'months': Text('3 months'),
    'year': Text('1 year')
  };

  String currentSegmentTitle = 'week';

  Widget getTimeDistributionCard() {
    String range = currentSegmentTitle;
    return TimeDistributionCard(range: range);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(builder: (context, model, child) {
      return Scaffold(
          appBar: PreferredSize(
            child: AppBar(
              title: Padding(
                  padding: EdgeInsets.only(top: 30, left: 10),
                  child: Text('Statistics', style: Styles.appBarTitle)),
              backgroundColor: Color(0xffffffff),
              brightness: Brightness.light,
            ),
            preferredSize: Size.fromHeight(80),
          ),
          body: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    CupertinoSlidingSegmentedControl(
                        groupValue: currentSegmentTitle,
                        children: tabs,
                        onValueChanged: (range) {
                          setState(() {
                            this.currentSegmentTitle = range;
                          });
                        }),
                    SizedBox(height: 15),
                    TimeDistributionCard(range: this.currentSegmentTitle)
                  ])
                ],
              )));
    });
  }
}
