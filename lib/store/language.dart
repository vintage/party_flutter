import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/widgets.dart';
import 'package:zgadula/repository/language.dart';
import 'package:zgadula/store/store.dart';

class LanguageModel extends StoreModel {
  LanguageRepository repository;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String _language;
  String get language => _language;

  LanguageModel(this.repository);

  @override
  initialize() async {
    _language = repository.getLanguage();
    _isLoading = false;
    notifyListeners();
  }

  changeLanguage(String language) async {
    _language = repository.setLanguage(language);
    notifyListeners();
  }

  static LanguageModel of(BuildContext context) =>
      ScopedModel.of<LanguageModel>(context);
}
