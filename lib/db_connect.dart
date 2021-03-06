import 'package:dio/dio.dart';
import 'current_user.dart';
import 'package:time_recipe/models/category.dart';
import 'package:time_recipe/models/task.dart';

class DBConnect {
  static const ip = 'http://47.94.172.0/dai';

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

  static Future<bool> addTask(Map<String, dynamic> params) async {
    FormData formData = FormData.fromMap(params);
    Response response = await Dio().post(ip + '/addTask.php', data: formData);
    return response.data == "1";
  }

  static Future<bool> addCategory(Map<String, dynamic> params) async {
    FormData formData = FormData.fromMap(params);
    Response response =
        await Dio().post(ip + '/addCategory.php', data: formData);
    return response.data == "1";
  }

  static Future<bool> updateCategory(Map<String, dynamic> params) async {
    FormData formData = FormData.fromMap(params);
    Response response =
        await Dio().post(ip + '/updateCategoryByCID.php', data: formData);
    return response.data == "1";
  }

  static Future<bool> deleteTaskByTID(int tID) async {
    Response response = await Dio().post(ip + '/deleteTaskByTID.php',
        data: FormData.fromMap({'t_id': tID}));
    return response.data == "1";
  }

  static Future<int> addNewUser(Map<String, dynamic> params) async {
    FormData formData = FormData.fromMap(params);
    Response response =
        await Dio().post(ip + '/addNewUser.php', data: formData);
    return int.parse(response.data);
  }

  static Future<bool> deleteCategoryById(int cID) async {
    Response response = await Dio().post(ip + '/deleteCategoryById.php',
        data: FormData.fromMap({'c_id': cID}));
    return response.data == "1";
  }

  static Future<Map<String, dynamic>> getTasksDistributionByTime(
      DateTime start, DateTime end) async {
    Response response = await Dio().get(ip +
        '/getTasksDistributionByTime.php?u_id=${CurrentUser.getId()}&start_time=$start&end_time=$end');
    Map<String, dynamic> result = new Map();
    for (var obj in response.data) {
      result[obj['date']] = obj['num'];
    }
    return result;
  }

  static Future<Map<String, dynamic>> getTasksDistributionByCategory() async {
    Response response = await Dio().get(
        ip + '/getTasksDistributionByCategory.php?u_id=${CurrentUser.getId()}');
    Map<String, dynamic> result = new Map();
    for (var obj in response.data) {
      result[obj['id']] = obj['num'];
    }
    return result;
  }

  static Future<Map<String, dynamic>> checkAuthentication(
      String email, String passwd) async {
    String url = ip + '/checkAuthentication.php?email=$email&passwd=$passwd';
    Response response = await Dio().get(url);
    Map<String, dynamic> result = new Map();
    result['auth'] = (response.data['result'] == "1");
    if (result['auth']) {
      result['u_id'] = int.parse(response.data['id']);
      result['username'] = response.data['username'];
    }
    return result;
  }

  static Future<String> getUserInfo() async {
    Response response =
        await Dio().get(ip + '/getUserInfo.php?id=${CurrentUser.getId()}');
    return response.data['username'];
  }

  static Future<List<Task>> getDayTasksByUID(DateTime date) async {
    Response response = await Dio().get(ip +
        '/getDayTasksByUID.php?id=${CurrentUser.getId()}&date=${date.toString()}');
    var tasks = <Task>[];
    for (var obj in response.data) {
      tasks.add(Task.fromJson(obj));
    }
    return tasks;
  }
}
