import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/models/contributor.dart';
import 'package:zgadula/repository/contributor.dart';
import 'package:zgadula/store/store.dart';

class ContributorModel extends StoreModel {
  ContributorRepository repository;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Contributor> _contributors = [];
  List<Contributor> get contributors => _contributors;

  ContributorModel(this.repository);

  load() async {
    if (_contributors.isNotEmpty) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    _contributors = await repository.getAll();
    _isLoading = false;
    notifyListeners();
  }

  static ContributorModel of(BuildContext context) =>
      ScopedModel.of<ContributorModel>(context);
}
