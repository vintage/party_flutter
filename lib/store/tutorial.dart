import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/widgets.dart';
import 'package:zgadula/store/store.dart';

class TutorialModel extends StoreModel {
  String _prefKey = 'is_tutorial_watched';

  bool _isWatched = false;
  bool get isWatched => _isWatched;

  @override
  Future initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isWatched = prefs.getBool(_prefKey) ?? false;
    notifyListeners();
  }

  Future watch() async {
    _isWatched = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_prefKey, true);
  }

  static TutorialModel of(BuildContext context) =>
      ScopedModel.of<TutorialModel>(context);
}
