import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:time_recipe/models/app_state_model.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/models/task.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/components/builders.dart';

class MineTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MineTabState();
  }
}

class _MineTabState extends State<MineTab> {
  String email;
  String password;
  List<Task> tasks = [];
  bool updated = false;

  Widget _todayCardBuidler() {
    Builders builders =
        new Builders(list: this.tasks, updateData: this._updateData);
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        shadowColor: Color(0x55000000),
        child: Container(
            constraints: BoxConstraints(
              minWidth: 400,
              maxWidth: MediaQuery.of(context).size.width - 40,
              maxHeight: MediaQuery.of(context).size.height - 200,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text('Future Tasks', style: Styles.baseFontBold),
                  SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height - 300,
                              maxWidth: MediaQuery.of(context).size.width),
                          child: ListView.builder(
                              itemCount: tasks.length,
                              shrinkWrap: true,
                              itemBuilder: builders.itemLineBuilder)))
                ])));
  }

  void _updateData() async {
    DBConnect.getTodayTasksByUID().then((value) {
      setState(() {
        this.tasks = [];
        for (Object obj in value) {
          tasks.add(obj);
        }
        this.updated = true;
      });
    });
  }

  Widget _logoutBuilder() {
    return Container(
        child: InkWell(
            onTap: () => logout(),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.logout, size: 24, color: Colors.grey[850]))));
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', 0);
    prefs.setBool('logged', false);
    Phoenix.rebirth(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!updated) _updateData();
    return Consumer<AppStateModel>(builder: (context, model, child) {
      return Scaffold(
          appBar: PreferredSize(
            child: AppBar(
              title: Padding(
                  padding: EdgeInsets.only(top: 30, left: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Mine', style: Styles.appBarTitle),
                        _logoutBuilder()
                      ])),
              backgroundColor: Color(0xffffffff),
              brightness: Brightness.light,
            ),
            preferredSize: Size.fromHeight(80),
          ),
          body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _todayCardBuidler(),
                )
              ],
            )
          ]));
    });
  }
}
