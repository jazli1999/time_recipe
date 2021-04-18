class Category {
  const Category({this.name, this.isArchived, this.id, this.icon});
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
