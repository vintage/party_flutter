import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/widgets.dart';
import 'package:zgadula/repository/tutorial.dart';
import 'package:zgadula/store/store.dart';

class TutorialModel extends StoreModel {
  TutorialRepository repository;

  bool _isWatched = false;
  bool get isWatched => _isWatched;

  TutorialModel(this.repository);

  @override
  initialize() async {
    _isWatched = await repository.isWatched();
    notifyListeners();
  }

  watch() async {
    _isWatched = await repository.watch();
    notifyListeners();
  }

  static TutorialModel of(BuildContext context) =>
      ScopedModel.of<TutorialModel>(context);
}
