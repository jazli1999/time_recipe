import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:time_recipe/styles.dart';
import 'package:time_recipe/db_connect.dart';

class LoginCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginCardState();
  }
}

class _LoginCardState extends State<LoginCard> {
  String email;
  String password;

  TextField emailField;
  TextField pwdField;

  void checkAuth() async {
    //fold soft keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    this.email = this.emailField.controller.text;
    this.password = this.pwdField.controller.text;

    bool isAuth =
        await DBConnect.checkAuthentication(this.email, this.password);
    if (isAuth)
      print('logged in');
    else
      print('Login failed');
  }

  Widget build(BuildContext context) {
    this.emailField = TextField(
      textAlign: TextAlign.start,
      style: Styles.baseFont,
      onChanged: (text) {
        email = text;
      },
      controller: TextEditingController(text: email),
      decoration: InputDecoration(
          hintText: 'E-mail',
          hintStyle: Styles.categoryNextTask,
          contentPadding: EdgeInsets.only(bottom: -15, left: 5)),
    );
    this.pwdField = TextField(
      textAlign: TextAlign.start,
      style: Styles.baseFont,
      onChanged: (text) {
        password = text;
      },
      obscureText: true,
      controller: TextEditingController(text: password),
      decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: Styles.categoryNextTask,
          contentPadding: EdgeInsets.only(bottom: -15, left: 5)),
    );
    return Center(
        child: Padding(
      padding: EdgeInsets.only(bottom: 100),
      child: SizedBox(
        height: 350,
        width: 400,
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
            shadowColor: Color(0x55000000),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text('Log in', style: Styles.headerFont),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.mail_outline_rounded,
                          size: 25, color: Color(0x88000000)),
                      SizedBox(width: 10),
                      SizedBox(width: 250, child: this.emailField),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.vpn_key_outlined,
                          size: 25, color: Color(0x88000000)),
                      SizedBox(width: 10),
                      SizedBox(width: 250, child: this.pwdField)
                    ],
                  ),
                  SizedBox(height: 30),
                  RaisedButton(
                      color: Color(0xbb845ba8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        checkAuth();
                      },
                      child: Text('Log In', style: Styles.baseFontBoldWhite))
                ])),
      ),
    ));
  }
}
