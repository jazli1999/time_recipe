import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:time_recipe/current_user.dart';
import 'package:time_recipe/db_connect.dart';
import 'package:time_recipe/styles.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;

  TextField emailField;
  TextField pwdField;

  void checkAuth() async {
    //fold soft keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    this.email = this.emailField.controller.text;
    this.password = this.pwdField.controller.text;

    Map<String, dynamic> authResult =
        await DBConnect.checkAuthentication(this.email, this.password);
    if (authResult['auth']) {
      setCurrentUser(authResult['u_id'], authResult['username']);
      Toast.show("Logged in", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green[400],
          textColor: Colors.white);
      Navigator.pushNamed(context, '/tasks');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('logged', true);
      prefs.setInt('id', authResult['u_id']);
    } else {
      Toast.show("邮箱或密码错误", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    }
  }

  void setCurrentUser(int id, String username) {
    CurrentUser.setId(id);
    CurrentUser.setIsLoggedIn(true);
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('logged')) {
      prefs.setBool('logged', false);
    }
    bool isLogged = prefs.getBool('logged');
    if (isLogged) {
      CurrentUser.setId(prefs.getInt('id'));
      CurrentUser.setIsLoggedIn(true);

      Navigator.pushNamed(context, '/tasks');
    } else {
      CurrentUser.setIsLoggedIn(false);
    }
  }

  Widget signUpHintBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            child: Text('没有账号？点此注册', style: Styles.textLink),
            onTap: () {
              Navigator.pushNamed(context, '/signUp');
            })
      ],
    );
  }

  Widget build(BuildContext context) {
    checkLoginStatus();

    TextEditingController emailController =
        new TextEditingController(text: email);
    TextEditingController pwdController =
        new TextEditingController(text: password);
    emailController.selection = TextSelection.fromPosition(
        TextPosition(offset: emailController.text.length));
    pwdController.selection = TextSelection.fromPosition(
        TextPosition(offset: pwdController.text.length));

    this.emailField = TextField(
      textAlign: TextAlign.start,
      style: Styles.baseFont,
      onChanged: (text) {
        email = text;
      },
      controller: emailController,
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
      controller: pwdController,
      decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: Styles.categoryNextTask,
          contentPadding: EdgeInsets.only(bottom: -15, left: 5)),
    );
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: SizedBox(
            height: 400,
            width: 400,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text('时 谱', style: Styles.logoFont),
                  Text('T i m e  R e c i p e', style: Styles.logoFontEng),
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
                  SizedBox(height: 40),
                  RaisedButton(
                      color: Color(0xbb845ba8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        checkAuth();
                      },
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child:
                              Text('Log In', style: Styles.baseFontBoldWhite))),
                  SizedBox(height: 10),
                  signUpHintBuilder(),
                ])),
      ),
    ));
  }
}
