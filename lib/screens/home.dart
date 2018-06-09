import 'package:flutter/material.dart';
import 'dart:convert';

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
  List<Category> categories = new List<Category>();
  List<Category> favoriteCategories = new List<Category>();
  Category focusedCategory;

  @override
  void initState() {
    super.initState();
    initStateCategories();
  }

  initStateCategories() async {
    String categoriesJson = await DefaultAssetBundle
        .of(context)
        .loadString('assets/data/categories.json');
    List<dynamic> categoryList = json.decode(categoriesJson);

    List<Category> categories = [];
    for (Map<String, dynamic> categoryMap in categoryList) {
      categories.add(Category.fromJson(categoryMap));
    }

    setState(() {
      this.categories = categories;
    });
  }

  _handleFavoriteToggle(Category category) {
    setState(() {
      if (favoriteCategories.contains(category)) {
        favoriteCategories.remove(category);
      } else {
        favoriteCategories.add(category);
      }
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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10.0),
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        crossAxisCount: 2,
        children: categories
            .map((category) => new CategoryListItem(
                  category: category,
                  showTitle: focusedCategory == category,
                  isFavorite: favoriteCategories.contains(category),
                  onTap: () => _handleCategoryTap(category),
                  onTapDown: () => _handleCategoryTapDown(category),
                  onFavoriteToggle: () => _handleFavoriteToggle(category),
                ))
            .toList(),
      ),
    );
  }
}
