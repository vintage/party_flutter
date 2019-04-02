import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zgadula/localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:zgadula/store/gallery.dart';

import '../shared/widgets.dart';

class GameGalleryScreen extends StatelessWidget {
  Widget buildGallery() {
    return ScopedModelDescendant<GalleryModel>(
        builder: (context, child, model) {
      var images = model.images;

      return CarouselSlider(
        enableInfiniteScroll: true,
        height: double.infinity,
        enlargeCenterPage: false,
        autoPlay: false,
        viewportFraction: 1.0,
        initialPage: images.indexOf(model.activeImage),
        items: images.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Image.file(item, fit: BoxFit.contain);
            },
          );
        }).toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: Icon(Icons.share),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: buildGallery(),
            ),
            BottomButton(
                child: Text(AppLocalizations.of(context).summaryBack),
                onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}
