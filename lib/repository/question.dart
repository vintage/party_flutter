import 'dart:core';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'package:zgadula/models/question.dart';

class QuestionRepository {
  Future<Map<String, List<Question>>> getAll(String languageCode) async {
    languageCode = languageCode.toLowerCase();
    List<dynamic> categoryList = json.decode(await rootBundle
        .loadString('assets/data/categories_$languageCode.json'));

    Map<String, List<Question>> questions = {};
    for (Map<String, dynamic> categoryMap in categoryList) {
      questions[categoryMap['id']] = List.from(categoryMap['questions']
          .map((name) => Question(name, categoryMap['name'])));
    }

    return questions;
  }

  _getRandomQuestions(List<Question> questions, int limit,
      {List<Question> excluded = const []}) {
    var allowedQuestions =
        questions.where((q) => !excluded.contains(q)).toList();
    allowedQuestions.shuffle();
    allowedQuestions = allowedQuestions.sublist(0, limit);

    return allowedQuestions;
  }

  List<Question> getRandomMixUp(
    Map<String, List<Question>> questions,
    int limit,
  ) {
    var keys = questions.keys.where((q) => q != 'mixup').toList();
    keys.shuffle();
    keys = keys.sublist(0, 3);

    List<Question> result = List.from(
      keys
          .map((k) => _getRandomQuestions(questions[k], (limit ~/ 3) + 1))
          .expand((i) => i),
    );

    return _getRandomQuestions(result, limit);
  }

  List<Question> getRandom(
      Map<String, List<Question>> questions, String categoryId, int limit,
      {List<Question> excluded = const []}) {
    if (categoryId == 'mixup') {
      return getRandomMixUp(questions, limit);
    }

    return _getRandomQuestions(
      questions[categoryId],
      limit,
      excluded: excluded,
    );
  }

  Question getNext(List<Question> questions, Question current) {
    int nextIndex = questions.indexOf(current) + 1;

    if (nextIndex == questions.length) {
      return null;
    }

    return questions[nextIndex];
  }
}
