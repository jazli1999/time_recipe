import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
  static const TextStyle categoryNextTask = TextStyle(
    color: Color(0xff8a8a8a),
    fontSize: 16,
  );

  static const TextStyle baseFont = TextStyle(
    fontSize: 18,
    color: Color(0xff000000),
  );

  static const TextStyle baseFontBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 30,
    color: Color(0xff000000),
    fontWeight: FontWeight.bold,
  );
}
