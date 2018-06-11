import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:zgadula/models/category.dart';

class CategoryService {
  static List<Category> _categories;

  static Future<List<Category>> getAll() async {
    if (_categories == null) {
      String categoriesJson =
      await rootBundle.loadString('assets/data/categories.json');
      List<dynamic> categoryList = json.decode(categoriesJson);

      List<Category> categories = [];
      for (Map<String, dynamic> categoryMap in categoryList) {
        categories.add(Category.fromJson(categoryMap));
      }

      _categories = categories;
    }

    return _categories;
  }

  static Future<Category> getById(String id) async {
    final categories = await getAll();
    return categories.firstWhere((category) => category.id == id);
  }
}
