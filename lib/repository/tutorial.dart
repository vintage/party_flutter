import 'dart:core';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialRepository {
  static const String storageWatchKey = 'is_tutorial_watched';

  final SharedPreferences storage;

  TutorialRepository({@required this.storage});

  isWatched() {
    return storage.getBool(storageWatchKey) ?? false;
  }

  watch() {
    storage.setBool(storageWatchKey, true);

    return true;
  }
}
