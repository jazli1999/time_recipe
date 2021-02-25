// mock data for UI development

import 'category.dart';

class CategoryRepository {
  static const _allCategories = <Category>[
    Category(
      name: 'Assignments',
      tasks: [],
      isArchived: false,
      id: 1,
      icon: '📚',
    ),
    Category(
      name: 'Grocery',
      tasks: [],
      isArchived: false,
      id: 2,
      icon: '🛒',
    ),
    Category(
      name: 'Laboratory',
      tasks: [],
      isArchived: false,
      id: 3,
      icon: '💻',
    ),
    Category(
      name: 'Bill Days',
      tasks: [],
      isArchived: false,
      id: 4,
      icon: '📜',
    ),
    Category(
      name: 'Graduation Design',
      tasks: [],
      isArchived: false,
      id: 5,
      icon: '⚒️',
    ),
  ];

  static List<Category> loadCategories() {
    return _allCategories;
  }
}
