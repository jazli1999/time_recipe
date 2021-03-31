import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:time_recipe/models/app_state_model.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/components/login_card.dart';

class MineTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MineTabState();
  }
}

class _MineTabState extends State<MineTab> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(builder: (context, model, child) {
      return Scaffold(
          appBar: PreferredSize(
            child: AppBar(
              title: Padding(
                  padding: EdgeInsets.only(top: 30, left: 5),
                  child: Text('Mine', style: Styles.appBarTitle)),
              backgroundColor: Color(0xffffffff),
              brightness: Brightness.light,
            ),
            preferredSize: Size.fromHeight(80),
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: LoginCard(),
          ));
    });
  }
}
