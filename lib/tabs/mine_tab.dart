import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:time_recipe/models/app_state_model.dart';
import 'package:time_recipe/styles.dart';
import 'package:time_recipe/current_user.dart';

class MineTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MineTabState();
  }
}

class _MineTabState extends State<MineTab> {
  String email;
  String password;

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
          body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Text(CurrentUser.getUsername())));
    });
  }
}
