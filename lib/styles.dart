import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
  static const baseSize = 18.0;
  static const secondSize = 16.0;
  static const thirdSize = 14.0;
  static const headerSize = 24.0;

  static const TextStyle logoFont = const TextStyle(
      fontFamily: 'QuanTangShiJ', color: Color(0xcc303030), fontSize: 60);

  static const TextStyle logoFontEng = const TextStyle(
      fontSize: 16,
      color: Color(0x88303030),
      fontFamily: 'Rayna',
      fontWeight: FontWeight.bold);

  static const TextStyle categoryNextTask = TextStyle(
    color: Color(0xff8a8a8a),
    fontSize: secondSize,
  );

  static const TextStyle baseFont = TextStyle(
    fontSize: baseSize,
    color: Color(0xff000000),
  );

  static const TextStyle headerFont = TextStyle(
    color: Color(0xff000000),
    fontSize: headerSize,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle baseFontBold = TextStyle(
    fontSize: baseSize,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle baseFontBoldWhite = TextStyle(
      fontSize: baseSize,
      fontWeight: FontWeight.bold,
      color: Color(0xffffffff));

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 30,
    color: Color(0xff000000),
    fontWeight: FontWeight.bold,
  );

  static const TextStyle secondFont = TextStyle(
    fontSize: secondSize,
    color: Color(0xff000000),
  );

  static const TextStyle secondFontWhite = TextStyle(
    fontSize: secondSize,
    color: Color(0xffffffff),
  );

  static const TextStyle secondFontBold = TextStyle(
    fontSize: secondSize,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle thirdFont = TextStyle(
    fontSize: thirdSize,
    color: Color(0xff000000),
  );

  static const TextStyle thirdFontBoldWhite = TextStyle(
    fontSize: thirdSize,
    color: Color(0xffffffff),
    fontWeight: FontWeight.bold,
  );
}
