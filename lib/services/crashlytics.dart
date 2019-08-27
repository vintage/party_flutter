import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsService {
  static initialize() {
//    Crashlytics.instance.enableInDevMode = true;
    FlutterError.onError = (FlutterErrorDetails details) {
      Crashlytics.instance.recordFlutterError(details);
    };
  }
}
