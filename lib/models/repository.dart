import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/db_connect.dart';

class Repository {
  static List<Category> categories;

  static Category getCategoryById(int id) {
    for (Category cat in Repository.categories) {
      if (cat.id == id) {
        return cat;
      }
    }
    return null;
  }

  static updateCategories() async {
    DBConnect.getCategoriesByUID().then((value) {
      Repository.categories = [];
      for (Object cat in value) {
        Repository.categories.add(cat);
      }
    });
  }
}
