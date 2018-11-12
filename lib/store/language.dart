import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/widgets.dart';
import 'package:zgadula/store/store.dart';

class LanguageModel extends StoreModel {
  String _languageKey = 'language';

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String _language;
  String get language => _language;

  @override
  Future initialize() async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _language = prefs.getString(_languageKey) ?? null;
    _isLoading = false;
    notifyListeners();
  }

  Future changeLanguage(String language) async {
    _language = language;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_languageKey, _language);
  }

  static LanguageModel of(BuildContext context) =>
      ScopedModel.of<LanguageModel>(context);
}
