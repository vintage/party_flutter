import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/models/question.dart';

class QuestionModel extends Model {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Map<String, List<Question>> _questions = {};
  Map<String, List<Question>> get questions => _questions;

  List<Question> _currentQuestions = [];
  List<Question> get currentQuestions => _currentQuestions;
  List<Question> get questionsPassed =>
      _currentQuestions.where((q) => q.isPassed).toList();
  List<Question> get questionsFailed =>
      _currentQuestions.where((q) => !q.isPassed).toList();

  Question _currentQuestion;
  Question get currentQuestion => _currentQuestion;

  Future initialize() async {
    _isLoading = true;
    notifyListeners();

    List<dynamic> categoryList =
        json.decode(await rootBundle.loadString('assets/data/categories.json'));
    for (Map<String, dynamic> categoryMap in categoryList) {
      _questions[categoryMap['id']] =
          List.from(categoryMap['questions'].map((name) => Question(name)));
    }
    _isLoading = false;
    notifyListeners();
  }

  _getRandomQuestions(String categoryId, int limit) {
    List<Question> questions = _questions[categoryId];
    questions.shuffle();
    questions = questions.sublist(0, limit);

    return questions;
  }

  generateCurrentQuestions(String categoryId) {
    // Mix-up category contains questions from other categories
    if (categoryId == 'mixup') {
      List<String> questionKeys =
          _questions.keys.where((q) => q != 'mixup').toList();
      questionKeys.shuffle();
      questionKeys = questionKeys.sublist(0, 3);

      _currentQuestions = List.from(
          questionKeys.map((c) => _getRandomQuestions(c, 3)).expand((i) => i));
      _currentQuestions.shuffle();
    } else {
      _currentQuestions = _getRandomQuestions(categoryId, 3);
    }

    _currentQuestion = _currentQuestions[0];
    notifyListeners();
  }

  setNextQuestion() {
    int nextIndex = _currentQuestions.indexOf(_currentQuestion) + 1;

    if (nextIndex == _currentQuestions.length) {
      _currentQuestion = null;
    } else {
      _currentQuestion = _currentQuestions[nextIndex];
    }

    notifyListeners();
  }

  markQuestionAsValid() {
    _currentQuestion.isPassed = true;
    notifyListeners();
  }

  markQuestionAsInvalid() {
    _currentQuestion.isPassed = false;
    notifyListeners();
  }

  static QuestionModel of(BuildContext context) =>
      ScopedModel.of<QuestionModel>(context);
}
