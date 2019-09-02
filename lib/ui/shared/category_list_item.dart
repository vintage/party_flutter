import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/localizations.dart';
import 'package:zgadula/store/category.dart';
import 'package:zgadula/ui/theme.dart';
import 'package:zgadula/models/category.dart';
import 'category_image.dart';

class CategoryListItem extends StatefulWidget {
  CategoryListItem({
    this.category,
    this.onTap,
  });

  final Category category;
  final VoidCallback onTap;

  @override
  _CategoryListItemState createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  Widget buildMetaItem(String text, [IconData icon]) {
    return Opacity(
      opacity: 0.7,
      child: Row(
        children: [
          icon != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(icon, size: 14),
                )
              : null,
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: ThemeConfig.categoriesMetaSize,
            ),
          ),
        ].where((o) => o != null).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int questionCount = widget.category.questions.length;

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Hero(
            tag: 'categoryImage-${widget.category.name}',
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: CategoryImage(photo: widget.category.getImagePath())),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Container(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  widget.category.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ThemeConfig.categoriesTextSize,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: Container(
                height: double.infinity,
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              ),
            ),
          ),
          ScopedModelDescendant<CategoryModel>(
            builder: (context, child, model) {
              return Positioned(
                bottom: 10,
                left: 10,
                child: buildMetaItem(
                  model.getPlayedCount(widget.category).toString(),
                  Icons.play_arrow,
                ),
              );
            },
          ),
          questionCount > 0
              ? Positioned(
                  bottom: 10,
                  right: 10,
                  child: buildMetaItem(
                    AppLocalizations.of(context)
                        .categoryItemQuestionsCount(questionCount),
                  ),
                )
              : null,
        ].where((o) => o != null).toList(),
      ),
    );
  }
}
