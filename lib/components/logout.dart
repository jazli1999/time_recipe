import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class Logout {
  Logout({this.context});

  final BuildContext context;

  Widget logoutBuilder() {
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
}
