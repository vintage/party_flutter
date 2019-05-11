import 'dart:core';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zgadula/models/category.dart';

class CategoryRepository {
  static const String storageCategoryPlayedCountKey = 'category_played_count';

  final SharedPreferences storage;

  CategoryRepository({@required this.storage});

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

  String _playedCountStorageKey(Category category) {
    return 'storageCategoryPlayedCountKey_${category.id}';
  }

  int getPlayedCount(Category category) {
    return storage.getInt(_playedCountStorageKey(category)) ?? 0;
  }

  int increasePlayedCount(Category category) {
    var gamesPlayed = getPlayedCount(category) + 1;
    storage.setInt(_playedCountStorageKey(category), gamesPlayed);

    return gamesPlayed;
  }
}
