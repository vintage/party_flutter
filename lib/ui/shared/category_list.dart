import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zgadula/services/analytics.dart';
import 'package:zgadula/store/category.dart';

import 'package:zgadula/ui/theme.dart';
import 'package:zgadula/models/category.dart';
import 'category_list_item.dart';

class CategoryList extends StatelessWidget {
  CategoryList({
    Key key,
    this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CategoryModel>(
        builder: (context, child, model) {
      return ListView(
        children: [
          GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.all(8),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
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
