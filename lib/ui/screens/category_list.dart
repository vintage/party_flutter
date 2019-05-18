import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/services/analytics.dart';
import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/ui/theme.dart';
import '../shared/widgets.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  CategoryListScreenState createState() {
    return new CategoryListScreenState();
  }
}

class CategoryListScreenState extends State<CategoryListScreen>
    with TickerProviderStateMixin {
  Widget buildContent(BuildContext context) {
    return ScopedModelDescendant<CategoryModel>(
      builder: (context, child, model) => ScopedModelDescendant<QuestionModel>(
            builder: (context, child, qModel) {
              return SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.all(0.0),
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                      crossAxisCount: ThemeConfig.categoriesGridCount,
                      children: model.categories.asMap().keys.map((index) {
                        var category = model.categories[index];

                        return CategoryListItem(
                          category: category,
                          onTap: () {
                            model.setCurrent(category);
                            qModel.generateSampleQuestions(category.id);

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
                ),
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          buildContent(context),
        ],
      ),
    );
  }
}
