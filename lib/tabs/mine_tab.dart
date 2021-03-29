import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:time_recipe/models/app_state_model.dart';
import 'package:time_recipe/styles.dart';

class MineTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MineTabState();
  }
}

class _MineTabState extends State<MineTab> {
  String email;
  String password;
  Widget _loginBuilder() {
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
                      SizedBox(
                          width: 250,
                          child: TextField(
                            textAlign: TextAlign.start,
                            style: Styles.baseFont,
                            onSubmitted: (text) {
                              email = text;
                            },
                            controller: TextEditingController(text: email),
                            decoration: InputDecoration(
                                hintText: 'E-mail',
                                hintStyle: Styles.categoryNextTask,
                                contentPadding:
                                    EdgeInsets.only(bottom: -15, left: 5)),
                          ))
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
                      SizedBox(
                          width: 250,
                          child: TextField(
                            textAlign: TextAlign.start,
                            style: Styles.baseFont,
                            onSubmitted: (text) {
                              password = text;
                            },
                            obscureText: true,
                            controller: TextEditingController(text: password),
                            decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: Styles.categoryNextTask,
                                contentPadding:
                                    EdgeInsets.only(bottom: -15, left: 5)),
                          ))
                    ],
                  ),
                  SizedBox(height: 30),
                  RaisedButton(
                      color: Color(0xbb845ba8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        print('E-mail: $email | Passwd: $password');
                      },
                      child: Text('Log In', style: Styles.baseFontBoldWhite))
                ])),
      ),
    ));
  }

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
        body: _loginBuilder(),
      );
    });
  }
}
