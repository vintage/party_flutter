import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:zgadula/models/category.dart';

class CategoryService {
  static Future<List<Category>> getAll() async {
    String categoriesJson = await rootBundle.loadString('assets/data/categories.json');
    List<dynamic> categoryList = json.decode(categoriesJson);

    List<Category> categories = [];
    for (Map<String, dynamic> categoryMap in categoryList) {
      categories.add(Category.fromJson(categoryMap));
    }

    return categories;
  }
}
