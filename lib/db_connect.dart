import 'package:dio/dio.dart';
import 'current_user.dart';
import 'package:time_recipe/models/category.dart';

class DBConnect {
  static const ip = 'http://47.94.172.0';

  static Future<List<Category>> getCategoriesByUID() async {
    Response response = await Dio().get(
        ip + '/getCategoriesByUID.php?u_id=' + CurrentUser.getId().toString());
    var categories = <Category>[];
    for (var index in response.data) {
      categories.add(Category.fromJson(index));
    }
    return categories;
  }
}
