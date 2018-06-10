import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:zgadula/models/category.dart';

class CategoryService {
  static Future<List<Category>> getAll() async {
    String categoriesJson =
        await rootBundle.loadString('assets/data/categories.json');
    List<dynamic> categoryList = json.decode(categoriesJson);

    List<Category> categories = [];
    for (Map<String, dynamic> categoryMap in categoryList) {
      categories.add(Category.fromJson(categoryMap));
    }

    // Mix category contains all questions
    Category mixUp =
        categories.firstWhere((category) => category.id == 'mixup');
    mixUp.questions = categories
        .where((category) {
          return category.id != 'mixup' &&
              category.id != 'adults' &&
              !category.modes.contains('sing') &&
              !category.modes.contains('humming');
        })
        .map((category) => category.questions)
        .expand((q) => q)
        .toList();

    return categories;
  }
}
