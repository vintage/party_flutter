import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:zgadula/models/category.dart';
import 'package:zgadula/screens/category_detail.dart';

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

  toggleFavorite(Category category) {
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

  isFavorite(Category category) {
    return favoriteCategories.contains(category);
  }

  openCategoryDetail(Category category) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new CategoryDetailScreen(category: category)));
  }

  Widget buildFavoriteIcon(bool isFavorite) {
    IconData iconData = isFavorite ? Icons.star : Icons.star_border;

    return new Icon(iconData, size: 38.0, color: Colors.amber);
  }

  List<Widget> buildCategoryBoxChild(Category category) {
    List<Widget> child = new List();

    if (focusedCategory == category) {
      child.add(new Center(
        child: new Container(
          color: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: new Text(category.name,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              )),
        ),
      ));
    }

    child.add(new Positioned(
      right: 0.0,
      bottom: 2.0,
      child: new IconButton(
          icon: buildFavoriteIcon(isFavorite(category)),
          onPressed: () => toggleFavorite(category)),
    ));

    return child;
  }

  Widget buildCategoryBox(Category category) {
    return new GestureDetector(
      onTap: () => _handleCategoryTap(category),
      onTapDown: (e) => _handleCategoryTapDown(category),
      child: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image:
                  new AssetImage(category.getImagePath()),
              fit: BoxFit.cover,
            ),
          ),
          child: new Stack(
            children: buildCategoryBoxChild(category),
          )),
    );
  }

  Widget buildGrid() {
    return new GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10.0),
      crossAxisSpacing: 5.0,
      mainAxisSpacing: 5.0,
      crossAxisCount: 2,
      children: categories.map((category) => buildCategoryBox(category)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: buildGrid(),
    );
  }
}
