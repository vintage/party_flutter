import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import '../shared/widgets.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  CategoryListScreenState createState() {
    return new CategoryListScreenState();
  }
}

class CategoryListScreenState extends State<CategoryListScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<CategoryModel>(
        builder: (context, child, model) =>
            CategoryList(categories: model.categories),
      ),
    );
  }
}
