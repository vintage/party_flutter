import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:zgadula/models/category.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageStage createState() => new HomePageStage();
}

class HomePageStage extends State<HomePage> {
  List<Category> categories = new List<Category>();

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

  @override
  void initState() {
    super.initState();
    initStateCategories();
  }

  Widget buildCategoryBox(Category category) {
    return new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('assets/images/categories/${category.image}'),
            fit: BoxFit.cover,
          ),
        ),
        child: new Stack(
          children: <Widget>[
            new Center(
              child: new Container(
                color: Colors.green,
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                child: new Text(category.name,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),
              ),
            ),
            new Positioned(
              right: 0.0,
              bottom: 2.0,
              child: new Icon(Icons.star, size: 38.0),
            ),
          ],
        ));
  }

  Widget buildGrid() {
    return new GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10.0),
      crossAxisSpacing: 5.0,
      mainAxisSpacing: 5.0,
      crossAxisCount: 2,
      children: new List<Widget>.generate(categories.length,
          (int index) => this.buildCategoryBox(categories[index])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: this.buildGrid(),
    );
  }
}
