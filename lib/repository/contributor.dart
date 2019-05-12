import 'dart:core';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'package:zgadula/models/contributor.dart';

class ContributorRepository {
  Future<List<Contributor>> getAll() async {
    List<dynamic> contributorsJson = json
        .decode(await rootBundle.loadString('assets/data/contributors.json'));

    List<Contributor> contributors = contributorsJson.map((data) {
      return Contributor(data['name'], data['username']);
    }).toList();

    return contributors;
  }
}
