import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zgadula/services/analytics.dart';
import 'package:zgadula/store/category.dart';

import 'package:zgadula/ui/theme.dart';
import 'package:zgadula/models/category.dart';
import 'category_list_item.dart';

class CategoryList extends StatefulWidget {
  CategoryList({
    this.categories,
  });

  final List<Category> categories;

  @override
  CategoryListState createState() => CategoryListState();
}

class CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    var categories = widget.categories;

    return ScopedModelDescendant<CategoryModel>(
        builder: (context, child, model) {
      return ListView(
        children: <Widget>[
          GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.all(0.0),
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            crossAxisCount: ThemeConfig.categoriesGridCount,
            children: categories.asMap().keys.map((index) {
              var category = categories[index];

              return CategoryListItem(
                category: category,
                onTap: () {
                  model.setCurrent(category);

                  AnalyticsService.logEvent(
                    'category_select',
                    {'category': category.name},
                  );

                  Navigator.pushNamed(
                    context,
                    '/category',
                  );
                },
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
