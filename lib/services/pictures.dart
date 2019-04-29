import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';

import 'package:zgadula/store/settings.dart';

class PicturesService {
  static Future<Directory> getDirectory(BuildContext context) async {
    var baseDir = await getTemporaryDirectory();
    var folder = SettingsModel.of(context).gamesPlayed.toString();

    return await Directory('${baseDir.path}/game_$folder')
        .create(recursive: true);
  }

  static Future<List<FileSystemEntity>> getFiles(BuildContext context) async {
    var dir = await getDirectory(context);

    return dir.listSync();
  }

  static Future<CameraDescription> getCamera() async {
    var cameras = await availableCameras();
    var frontCamera = cameras.firstWhere((cameraDescription) =>
        cameraDescription.lensDirection == CameraLensDirection.front);

    return frontCamera;
  }
}
