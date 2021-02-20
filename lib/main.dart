import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'model/app_state_model.dart';
void main() {
  // This app is designed only to work vertically, so we limit
  // orientations to portrait up and down.
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xffffff)
    )
  );

  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      create: (context) => AppStateModel()..loadProducts(),
      child: TimeRecipe(),
    ),
  );
}