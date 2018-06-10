import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zgadula/services/category.dart';
import 'package:zgadula/models/category.dart';
import 'package:zgadula/screens/category_detail.dart';
import 'package:zgadula/components/category_list_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomeScreenStage createState() => new HomeScreenStage();
}

class HomeScreenStage extends State<HomeScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<Category> categories = new List<Category>();
  List<String> favoriteIds = new List<String>();
  Category focusedCategory;

  @override
  void initState() {
    super.initState();
    initStateCategories();
  }

  initStateCategories() async {
    List<Category> categories = await CategoryService.getAll();

    final SharedPreferences prefs = await _prefs;
    final List<String> favoriteIds = prefs.getStringList('favorite_list') ?? [];

    setState(() {
      this.categories = categories;
      this.favoriteIds = favoriteIds;
    });
  }

  _handleFavoriteToggle(Category category) async {
    final favoriteIds = this.favoriteIds.toList();

    if (favoriteIds.contains(category.id)) {
      favoriteIds.remove(category.id);
    } else {
      favoriteIds.add(category.id);
    }

    final SharedPreferences prefs = await _prefs;
    prefs.setStringList('favorite_list', favoriteIds);

    setState(() {
      this.favoriteIds = favoriteIds;
    });
  }

  _handleCategoryTap(Category category) {
    openCategoryDetail(category);

    setState(() {
      focusedCategory = null;
    });
  }

  _handleCategoryTapDown(Category category) {
    setState(() {
      focusedCategory = category;
    });
  }

  openCategoryDetail(Category category) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new CategoryDetailScreen(category: category)));
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isPortrait = orientation == Orientation.portrait;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10.0),
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        crossAxisCount: isPortrait ? 2 : 3,
        children: categories
            .map((category) => new CategoryListItem(
                  category: category,
                  showTitle: focusedCategory == category,
                  isFavorite: favoriteIds.contains(category.id),
                  onTap: () => _handleCategoryTap(category),
                  onTapDown: () => _handleCategoryTapDown(category),
                  onFavoriteToggle: () => _handleFavoriteToggle(category),
                ))
            .toList(),
      ),
    );
  }
}
