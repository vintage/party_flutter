import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/models/category.dart';

class CategoryModel extends Model {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  List<Category> _favourites = [];
  List<Category> get favourites => _favourites;

  Category _currentCategory;
  Category get currentCategory => _currentCategory;

  Future initialize() async {
    _isLoading = true;

    notifyListeners();

    List<dynamic> categoryList = json.decode(await rootBundle.loadString('assets/data/categories.json'));
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
