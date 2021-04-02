import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:time_recipe/login_page.dart';
import 'package:time_recipe/current_user.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/homepage.dart';

class TimeRecipe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TimeRecipeState();
  }
}

class _TimeRecipeState extends State<TimeRecipe> {
  Widget nextPage = LoginPage();

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('logged')) {
      prefs.setBool('logged', false);
    }
    bool isLogged = prefs.getBool('logged');
    if (isLogged) {
      CurrentUser.setId(prefs.getInt('id'));
      String username = await DBConnect.getUserInfo();
      CurrentUser.setUsername(username);
      CurrentUser.setIsLoggedIn(true);

      setState(() => {this.nextPage = HomePage()});
    } else {
      CurrentUser.setIsLoggedIn(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLoginStatus();
    return MaterialApp(
      home: nextPage,
    );
  }
}
