import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
  static const baseSize = 18.0;
  static const secondSize = 16.0;

  static const TextStyle categoryNextTask = TextStyle(
    color: Color(0xff8a8a8a),
    fontSize: secondSize,
  );

  static const TextStyle baseFont = TextStyle(
    fontSize: baseSize,
    color: Color(0xff000000),
  );

  static const TextStyle baseFontBold = TextStyle(
    fontSize: baseSize,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 30,
    color: Color(0xff000000),
    fontWeight: FontWeight.bold,
  );

  static const TextStyle secondFont = TextStyle(
    fontSize: secondSize,
  );

  static const TextStyle secondFontBold = TextStyle(
    fontSize: secondSize,
    fontWeight: FontWeight.bold,
  );
}
