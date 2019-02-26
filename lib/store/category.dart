import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/models/category.dart';
import 'package:zgadula/repository/category.dart';
import 'package:zgadula/store/store.dart';

class CategoryModel extends StoreModel {
  CategoryRepository repository;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  List<Category> _favourites = [];
  List<Category> get favourites => _favourites;

  Category _currentCategory;
  Category get currentCategory => _currentCategory;

  CategoryModel(this.repository);

  load(String languageCode) async {
    _isLoading = true;
    notifyListeners();

    _categories = await repository.getAll(languageCode);
    _isLoading = false;
    notifyListeners();
  }

  setCurrent(Category category) {
    _currentCategory = category;
    notifyListeners();
  }

  toggleFavorite(Category category) {
    _favourites = repository.toggleFavorite(_favourites, category);
    notifyListeners();
  }

  static CategoryModel of(BuildContext context) =>
      ScopedModel.of<CategoryModel>(context);
}
