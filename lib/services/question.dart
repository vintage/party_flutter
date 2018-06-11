import 'dart:async' show Future;

import 'package:zgadula/services/category.dart';
import 'package:zgadula/models/question.dart';

class QuestionService {
  static Future<List<Question>> getByCategoryId(String id) async {
    final category = await CategoryService.getById(id);

    // Mix-up category contains questions from other categories
    if (category.id == 'mixup') {
      final categories = await CategoryService.getAll();
      return categories
          .where((category) {
            return category.id != 'mixup' &&
                category.id != 'adults' &&
                !category.modes.contains('sing') &&
                !category.modes.contains('humming');
          })
          .map((category) => category.questions)
          .expand((q) => q)
          .toList();
    }

    return category.questions;
  }
}
