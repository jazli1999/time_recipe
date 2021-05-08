import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:time_recipe/styles.dart';
import 'package:time_recipe/models/app_state_model.dart';
import 'package:time_recipe/components/time_distribution_card.dart';
import 'package:time_recipe/components/category_distribution_card.dart';
import 'package:time_recipe/components/bottom_bar.dart';
import 'package:time_recipe/components/add_button.dart';
import 'package:time_recipe/components/logout.dart';

class StatisticsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatisticsTabState();
  }
}

class _StatisticsTabState extends State<StatisticsTab> {
  Orientation curOrientation;

  Widget _portraitView() {
    return SingleChildScrollView(
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
                  CategoryDistributionCard(orientation: curOrientation),
                ])
              ],
            )));
  }

  Widget _landscapeView() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TimeDistributionCard(),
              SizedBox(width: 20),
              CategoryDistributionCard(orientation: curOrientation)
            ])));
  }

  @override
  Widget build(BuildContext context) {
    Logout logout = new Logout(context: context);
    return Consumer<AppStateModel>(builder: (context, model, child) {
      return Scaffold(
          appBar: PreferredSize(
            child: AppBar(
              title: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Statistics', style: Styles.appBarTitle),
                        logout.logoutBuilder()
                      ])),
              backgroundColor: Color(0xffffffff),
              brightness: Brightness.light,
            ),
            preferredSize: Size.fromHeight(80),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: getFab(),
          bottomNavigationBar: BottomBar(selected: 'statistics'),
          body: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.landscape &&
                MediaQuery.of(context).size.width > 800) {
              curOrientation = Orientation.landscape;
              return _landscapeView();
            } else {
              curOrientation = Orientation.portrait;
              return _portraitView();
            }
          }));
    });
  }
}
