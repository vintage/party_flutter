import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GalleryHorizontal extends StatelessWidget {
  GalleryHorizontal({
    this.items,
    this.onTap,
  });

  final List<FileSystemEntity> items;
  final Function(FileSystemEntity) onTap;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      enableInfiniteScroll: true,
      height: 100.0,
      enlargeCenterPage: true,
      autoPlay: true,
      viewportFraction: 0.23,
      items: items.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                  onTap: () {
                    onTap(item);
                  },
                  child: Image.file(item, fit: BoxFit.contain)),
            );
          },
        );
      }).toList(),
    );
  }
}
