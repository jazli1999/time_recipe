import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:time_recipe/styles.dart';
import 'package:time_recipe/db_connect.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  String email;
  String password;
  String repeatPwd;

  TextField emailField;
  TextField pwdField;
  TextField repeatField;

  void _addNewUser() {
    FocusScope.of(context).requestFocus(FocusNode());
    email = emailField.controller.text;
    password = pwdField.controller.text;
    repeatPwd = repeatField.controller.text;

    if (password != repeatPwd) {
      Toast.show("两次输入的密码不一致", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.deepOrange[600],
          textColor: Colors.white);
      return;
    }

    // repeat password correct, send request
    Map<String, dynamic> params = new Map();
    params['email'] = email;
    params['passwd'] = password;
    DBConnect.addNewUser(params).then((value) async {
      if (value == 0) {
        Toast.show("账号已存在", context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.blue[600],
            textColor: Colors.white);
      } else {
        Toast.show("注册成功", context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.green[400],
            textColor: Colors.white);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('logged', true);
        prefs.setInt('id', value);
        Navigator.pushNamed(context, '/tasks');
      }
    });
  }

  Widget logInHintBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            child: Text('点此返回登录页面', style: Styles.textLink),
            onTap: () {
              Navigator.pop(context);
            })
      ],
    );
  }

  Widget build(BuildContext context) {
    TextEditingController emailController =
        new TextEditingController(text: email);
    TextEditingController pwdController =
        new TextEditingController(text: password);
    TextEditingController repeatController =
        new TextEditingController(text: repeatPwd);

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
        email = text;
      },
      obscureText: true,
      controller: pwdController,
      decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: Styles.categoryNextTask,
          contentPadding: EdgeInsets.only(bottom: -15, left: 5)),
    );

    this.repeatField = TextField(
      textAlign: TextAlign.start,
      style: Styles.baseFont,
      onChanged: (text) {
        email = text;
      },
      obscureText: true,
      controller: repeatController,
      decoration: InputDecoration(
          hintText: 'Repeat password',
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
                        Text('用户注册', style: Styles.logoFont),
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
                            SizedBox(width: 250, child: this.pwdField),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(width: 35),
                            SizedBox(width: 250, child: this.repeatField),
                          ],
                        ),
                        SizedBox(height: 40),
                        RaisedButton(
                            color: Color(0xbb845ba8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            onPressed: () {
                              _addNewUser();
                            },
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text('注 册',
                                    style: Styles.baseFontBoldWhite))),
                        SizedBox(height: 10),
                        logInHintBuilder(),
                      ],
                    )))));
  }
}
