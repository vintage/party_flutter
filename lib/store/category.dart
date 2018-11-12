import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/models/category.dart';
import 'package:zgadula/store/store.dart';

class CategoryModel extends StoreModel {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  List<Category> _favourites = [];
  List<Category> get favourites => _favourites;

  Category _currentCategory;
  Category get currentCategory => _currentCategory;

  load(String languageCode) async {
    _isLoading = true;
    notifyListeners();

    languageCode = languageCode.toLowerCase();
    List<dynamic> categoryList =
    json.decode(await rootBundle.loadString('assets/data/categories_$languageCode.json'));
    _categories.clear();
    for (Map<String, dynamic> categoryMap in categoryList) {
      _categories.add(Category.fromJson(categoryMap));
    }
    _isLoading = false;

    notifyListeners();
  }

  setCurrent(Category category) {
    _currentCategory = category;
    notifyListeners();
  }

  toggleFavorite(Category category) {
    if (_favourites.contains(category)) {
      _favourites.remove(category);
    } else {
      _favourites.add(category);
    }

    notifyListeners();
  }

  static CategoryModel of(BuildContext context) =>
      ScopedModel.of<CategoryModel>(context);
}
