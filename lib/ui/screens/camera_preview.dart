import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:zgadula/services/analytics.dart';
import 'package:zgadula/services/pictures.dart';

class CameraPreviewScreen extends StatefulWidget {
  @override
  CameraPreviewScreenState createState() => CameraPreviewScreenState();
}

class CameraPreviewScreenState extends State<CameraPreviewScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  static const pictureInterval = 8;

  CameraController controller;
  Directory pictureDir;
  Timer pictureTimer;
  FileSystemEntity lastImage;

  AnimationController imageAnimationController;
  Animation<double> imageAnimation;
  double lastImageOpacity;
  Duration opacityAnimationDuration = Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    startTimer();
    initCamera();
    initAnimations();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    imageAnimationController?.dispose();
    stopTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        initCamera();
      }
    }
  }

  initCamera() async {
    if (controller != null) {
      await controller.dispose();
    }

    pictureDir = await PicturesService.getDirectory(context);
    var frontCamera = await PicturesService.getCamera();
    if (frontCamera == null) {
      return;
    }

    controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    try {
      await controller.initialize();
    } on CameraException {
      print("Camera initialization exception");
    }

    if (mounted) {
      setState(() {});
    }
  }

  initAnimations() {
    imageAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    imageAnimation =
        Tween<double>(begin: 0, end: 1).animate(imageAnimationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                lastImageOpacity = 0;
                Future.delayed(opacityAnimationDuration).then((_) {
                  imageAnimationController.reset();
                });
              });
            }
          });
  }

  startTimer() {
    pictureTimer =
        Timer.periodic(const Duration(seconds: pictureInterval), savePicture);
  }

  stopTimer() {
    pictureTimer?.cancel();
  }

  savePicture(Timer timer) {
    if (controller == null) {
      return false;
    }

    AnalyticsService.logEvent('picture_taken', {});

    controller.takePicture('${pictureDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');

    Future.delayed(Duration(seconds: 1)).then((_) async {
      List<FileSystemEntity> files = await PicturesService.getFiles(context);
      setState(() {
        lastImageOpacity = 1;
        lastImage = files.last;
        imageAnimationController.forward();
      });
    });
  }

  Widget buildImageTaken() {
    return Positioned(
      right: 0,
      top: 0,
      child: AnimatedOpacity(
        opacity: lastImageOpacity,
        duration: opacityAnimationDuration,
        child: ScaleTransition(
          scale: imageAnimationController,
          child: Image.file(
            lastImage,
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }

    return Center(
      child: RotatedBox(
        quarterTurns: 1,
        child: Stack(
          children: [
            CameraPreview(controller),
            lastImage != null ? buildImageTaken() : null,
          ].where((w) => w != null).toList(),
        ),
      ),
    );
  }
}
