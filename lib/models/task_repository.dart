import 'task.dart';

class TaskRepository {
  static final _allTasks = <Task>[
    Task(
      categoryId: 1,
      dateTime: DateTime(2021, 3, 12),
      isDone: false,
      id: 1,
      name: 'Chapter 4',
    ),
    Task(
        categoryId: 1,
        dateTime: DateTime(2021, 3, 15),
        isDone: false,
        id: 2,
        name: '期中调研论文论文'),
    Task(
        categoryId: 1,
        dateTime: DateTime(2021, 3, 20),
        isDone: false,
        id: 3,
        name: 'Chapter 5 主题 Presentation'),
  ];

  static List<Task> loadTasks() {
    return _allTasks;
  }
}
