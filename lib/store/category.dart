import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/models/category.dart';
import 'package:zgadula/repository/category.dart';
import 'package:zgadula/store/store.dart';

class CategoryModel extends StoreModel {
  CategoryRepository repository;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Map<String, Category> _categories = {};
  List<Category> get categories => _categories.values.toList();

  List<String> _favourites = [];
  List<Category> get favourites =>
      _favourites.map((id) => _categories[id]).where((c) => c != null).toList();

  Category _currentCategory;
  Category get currentCategory => _currentCategory;

  Map<String, int> _playedCount = {};
  Map<String, int> get playedCount => _playedCount;

  CategoryModel(this.repository);

  load(String languageCode) async {
    _isLoading = true;
    notifyListeners();

    _categories = Map.fromIterable(
      await repository.getAll(languageCode),
      key: (c) => c.id,
      value: (c) => c,
    );
    _favourites = repository.getFavorites();
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
