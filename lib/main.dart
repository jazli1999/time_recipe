import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'models/app_state_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // This app is designed only to work vertically, so we limit
  // orientations to portrait up and down
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent));

  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      create: (context) => AppStateModel(),
      child: TimeRecipe(),
    ),
  );
}
