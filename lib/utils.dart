import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/models/repository.dart';

class Utils {
  static String getCategoryHeader(Category category) {
    if (category == null) {
      return ' ';
    }
    return category.icon + ' ' + category.name;
  }

  static Category findCategoryById(int id) {
    for (Category cat in Repository.categories) {
      if (cat.id == id) {
        return cat;
      }
    }
    return null;
  }
}
