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

  static String dateFormatter(DateTime dateTime) {
    return '${dateTime.year} 年 ${dateTime.month} 月 ${dateTime.day} 日';
  }

  static String timeFormatter(DateTime dateTime) {
    String hour =
        dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
    String minute = dateTime.minute < 10
        ? '0${dateTime.minute}'
        : dateTime.minute.toString();
    return '$hour : $minute';
  }

  static const mockNextTasks = <String>[
    'Chapter 4 today',
    'Buy milk in 6 days',
    'Presentation in 15 dyas',
    'Rent in 28 days',
    'Midterm in 2 months'
  ];

  static String calcNextTask(int index) {
    return mockNextTasks[index % 5];
  }
}
