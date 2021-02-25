import 'package:flutter/foundation.dart' as foundation;
import 'category.dart';
import 'category_repository.dart';

class AppStateModel extends foundation.ChangeNotifier {
  List<Category> getAllCategories() {
    return CategoryRepository.loadCategories();
  }

  void loadCategories() {
    CategoryRepository.loadCategories();
    notifyListeners();
  }

  static const mockNextTasks = <String>[
    'Chapter 4 today',
    'Buy milk in 6 days',
    'Presentation in 15 dyas',
    'Rent in 28 days',
    'Midterm in 2 months'
  ];

  String calcNextTask(int index) {
    return mockNextTasks[index];
  }
}
