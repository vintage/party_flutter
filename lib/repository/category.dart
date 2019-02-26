import 'dart:core';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:zgadula/models/category.dart';

class CategoryRepository {
  Future<List<Category>> getAll(String languageCode) async {
    languageCode = languageCode.toLowerCase();
    List<dynamic> categoryList = json.decode(await rootBundle
        .loadString('assets/data/categories_$languageCode.json'));

    List<Category> categories = [];
    for (Map<String, dynamic> categoryMap in categoryList) {
      categories.add(Category.fromJson(categoryMap));
    }

    return categories;
  }

  List<Category> toggleFavorite(List<Category> favourites, Category selected) {
    if (favourites.contains(selected)) {
      favourites.remove(selected);
    } else {
      favourites.add(selected);
    }

    return favourites;
  }
}
