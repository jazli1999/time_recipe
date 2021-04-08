class Task {
  Task(
      {this.name,
      this.dateTime,
      this.isDone,
      this.categoryId,
      this.id,
      this.note});

  final String name;
  final DateTime dateTime;
  final bool isDone;
  final int categoryId;
  final int id;
  String note;

  static Task fromJson(Map<String, dynamic> jsonObj) {
    return new Task(
      name: jsonObj['t_name'],
      id: int.parse(jsonObj['id']),
      categoryId: int.parse(jsonObj['c_id']),
      dateTime: DateTime.parse(jsonObj['date_time']),
      isDone: jsonObj['is_done'] != "0",
    );
  }
}
