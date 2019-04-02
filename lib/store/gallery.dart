import 'dart:io';

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/widgets.dart';
import 'package:zgadula/store/store.dart';

class GalleryModel extends StoreModel {
  FileSystemEntity _activeImage;
  FileSystemEntity get activeImage => _activeImage;

  List<FileSystemEntity> _images = [];
  List<FileSystemEntity> get images => _images;

  update(List<FileSystemEntity> images) {
    _images = images;
    notifyListeners();
  }

  setActive(FileSystemEntity image) {
    _activeImage = image;
    notifyListeners();
  }

  static GalleryModel of(BuildContext context) =>
      ScopedModel.of<GalleryModel>(context);
}
