import 'package:dio/dio.dart';
import 'current_user.dart';
import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/models/task.dart';

class DBConnect {
  static const ip = 'http://47.94.172.0';

  static Future<List<Category>> getCategoriesByUID() async {
    Response response = await Dio().get(
        ip + '/getCategoriesByUID.php?u_id=' + CurrentUser.getId().toString());
    var categories = <Category>[];
    for (var obj in response.data) {
      categories.add(Category.fromJson(obj));
    }
    return categories;
  }

  static Future<List<Task>> getTasksByCID(int cId) async {
    Response response =
        await Dio().get(ip + '/getTasksByCID.php?c_id=' + cId.toString());
    var tasks = <Task>[];
    for (var obj in response.data) {
      tasks.add(Task.fromJson(obj));
    }
    return tasks;
  }

  static Future<bool> updateTaskByTID(Map<String, dynamic> params) async {
    FormData formData = FormData.fromMap(params);
    Response response =
        await Dio().post(ip + '/updateTaskByTID.php', data: formData);
    return response.data == "1";
  }

  static Future<bool> deleteTaskByTID(int tID) async {
    Response response = await Dio().post(ip + '/deleteTaskByTID.php',
        data: FormData.fromMap({'t_id': tID}));
    return response.data == "1";
  }
}
