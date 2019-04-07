import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:zgadula/services/pictures.dart';

class CameraPreviewScreen extends StatefulWidget {
  @override
  CameraPreviewScreenState createState() => CameraPreviewScreenState();
}

class CameraPreviewScreenState extends State<CameraPreviewScreen> {
  static const pictureInterval = 15;

  CameraController controller;
  Directory pictureDir;
  Timer pictureTimer;
  int pictureTaken = 0;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  initCamera() async {
    pictureDir = await PicturesService.getDirectory(context);
    var frontCamera = await PicturesService.getCamera();
    if (frontCamera == null) {
      return;
    }

    controller = CameraController(frontCamera, ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }

      startTimer();
      setState(() {});
    });
  }

  startTimer() {
    pictureTimer = Timer.periodic(const Duration(seconds: pictureInterval), savePicture);
  }

  stopTimer() {
    pictureTimer?.cancel();
  }

  savePicture(Timer timer) {
    controller.takePicture('${pictureDir.path}/$pictureTaken.png');
    pictureTaken += 1;
  }

  @override
  void dispose() {
    controller?.dispose();
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }

    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Transform.rotate(
          angle: pi / 2,
          child: CameraPreview(controller),
        ),
    );
  }
}
