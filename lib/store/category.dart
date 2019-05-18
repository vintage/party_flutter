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

  List<String> _favourites = [];
  List<String> get favourites => _favourites;

  Category _currentCategory;
  Category get currentCategory => _currentCategory;

  Map<String, int> _playedCount = {};
  Map<String, int> get playedCount => _playedCount;

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

  isFavorite(Category category) {
    return _favourites.contains(category.id);
  }

  toggleFavorite(Category category) {
    _favourites = repository.toggleFavorite(_favourites, category);
    notifyListeners();
  }

  getPlayedCount(Category category) {
    if (!_playedCount.containsKey(category.id)) {
      _playedCount[category.id] = repository.getPlayedCount(category);
    }

    return _playedCount[category.id];
  }

  increasePlayedCount(Category category) async {
    _playedCount[category.id] = repository.increasePlayedCount(category);
    notifyListeners();
  }

  static CategoryModel of(BuildContext context) =>
      ScopedModel.of<CategoryModel>(context);
}
