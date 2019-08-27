import 'dart:core';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageRepository {
  static const String storageLanguageKey = 'language';

  final SharedPreferences storage;

  LanguageRepository({@required this.storage});

  String getLanguage() {
    return storage.getString(storageLanguageKey);
  }

  String setLanguage(String language) {
    storage.setString(storageLanguageKey, language);

    return language;
  }
}
