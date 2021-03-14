import 'package:flutter/foundation.dart';

class Category {
  const Category(
      {@required this.name,
      @required this.isArchived,
      @required this.id,
      @required this.icon})
      : assert(name != null),
        assert(isArchived != null),
        assert(id != null),
        assert(icon != null);

  final String name;
  final bool isArchived;
  final int id;
  final String icon;

  static Category fromJson(Map<String, dynamic> jsonObj) {
    return new Category(
        icon: jsonObj['icon'],
        id: int.parse(jsonObj['id']),
        name: jsonObj['c_name'],
        isArchived: jsonObj['is_archived'] != "0");
  }
}
