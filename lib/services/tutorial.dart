import 'dart:async' show Future;

import 'package:shared_preferences/shared_preferences.dart';


class TutorialService {
  static String _prefKey = 'is_tutorial_watched';
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<bool> isWatched() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getBool(_prefKey) ?? false;
  }

  static void watchTutorial() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(_prefKey, true);
  }
}
