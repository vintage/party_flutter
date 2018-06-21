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
  HomeScreenStage createState() => HomeScreenStage();
}

class HomeScreenStage extends State<HomeScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<Category> categories = List<Category>();
  List<String> favoriteIds = List<String>();

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
  }

  openCategoryDetail(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailScreen(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isPortrait = orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(2.0),
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
          crossAxisCount: isPortrait ? 2 : 3,
          children: categories
              .map((category) => CategoryListItem(
                    category: category,
                    isFavorite: favoriteIds.contains(category.id),
                    onTap: () => _handleCategoryTap(category),
                    onFavoriteToggle: () => _handleFavoriteToggle(category),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
