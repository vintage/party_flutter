import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:zgadula/services/analytics.dart';
import 'package:zgadula/store/gallery.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zgadula/ui/templates/screen.dart';
import 'package:path/path.dart';

import '../theme.dart';

class GameGalleryScreen extends StatelessWidget {
  Widget buildGallery() {
    return ScopedModelDescendant<GalleryModel>(
        builder: (context, child, model) {
      var images = model.images;

      return CarouselSlider(
        enableInfiniteScroll: true,
        height: MediaQuery.of(context).size.height * 0.8,
        enlargeCenterPage: false,
        autoPlay: false,
        viewportFraction: 1.0,
        initialPage: images.indexOf(model.activeImage),
        items: images.map((item) {
          return Stack(children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: SpinKitRing(color: secondaryColor, size: 70.0),
            ),
            Builder(
              builder: (BuildContext context) {
                return Center(
                  child: Stack(
                    children: [
                      Image.file(item, fit: BoxFit.contain),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: FloatingActionButton(
                          elevation: 0.0,
                          child: Icon(Icons.share),
                          backgroundColor: Theme.of(context).primaryColor,
                          onPressed: () async {
                            AnalyticsService.logEvent('picture_share', {});

                            await Share.file(
                              'Zgadula',
                              basename(item.path),
                              File(item.path).readAsBytesSync(),
                              'image/png',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ]);
        }).toList(),
        onPageChanged: (index) {
          model.setActive(images[index]);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      showBack: true,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: buildGallery(),
            ),
          ],
        ),
      ),
    );
  }
}
