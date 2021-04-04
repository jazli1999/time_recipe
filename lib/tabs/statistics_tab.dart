import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/models/app_state_model.dart';
import 'package:time_recipe/components/time_distribution_card.dart';
import 'package:time_recipe/components/category_distribution_card.dart';
import 'package:time_recipe/components/bottom_bar.dart';
import 'package:time_recipe/components/add_button.dart';

class StatisticsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatisticsTabState();
  }
}

class _StatisticsTabState extends State<StatisticsTab> {
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: getFab(),
          bottomNavigationBar: getBar(),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        SizedBox(height: 15),
                        TimeDistributionCard(),
                        SizedBox(height: 10),
                        CategoryDistributionCard(),
                      ])
                    ],
                  ))));
    });
  }
}
