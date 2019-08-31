import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/store/category.dart';
import '../shared/widgets.dart';
import 'package:zgadula/ui/templates/screen.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      child: ScopedModelDescendant<CategoryModel>(
        builder: (context, child, model) =>
            CategoryList(categories: model.categories),
      ),
    );
  }
}
