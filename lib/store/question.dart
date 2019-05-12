import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/models/question.dart';
import 'package:zgadula/repository/question.dart';
import 'package:zgadula/store/store.dart';

class QuestionModel extends StoreModel {
  QuestionRepository repository;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Map<String, List<Question>> _questions = {};
  Map<String, List<Question>> get questions => _questions;

  List<Question> _sampleQuestions = [];
  List<Question> get sampleQuestions => _sampleQuestions;

  Map<String, List<Question>> _sampleQuestionsByCategory = {};
  Map<String, List<Question>> get sampleQuestionsByCategory =>
      _sampleQuestionsByCategory;

  List<Question> _currentQuestions = [];
  List<Question> get currentQuestions => _currentQuestions;
  List<Question> get questionsPassed =>
      _currentQuestions.where((q) => q.isPassed).toList();
  List<Question> get questionsFailed =>
      _currentQuestions.where((q) => !q.isPassed).toList();
  List<Question> _latestQuestions = [];
  List<Question> get latestQuestions => _latestQuestions;

  Question _currentQuestion;
  Question get currentQuestion => _currentQuestion;

  QuestionModel(this.repository);

  load(String languageCode) async {
    _isLoading = true;
    notifyListeners();

    _questions = await repository.getAll(languageCode);
    _sampleQuestionsByCategory = {};
    _isLoading = false;
    notifyListeners();
  }

  generateSampleQuestions(String categoryId) {
    if (!_sampleQuestionsByCategory.containsKey(categoryId)) {
      _sampleQuestionsByCategory[categoryId] = repository.getRandom(
        _questions,
        categoryId,
        4,
      );
    }

    _sampleQuestions = _sampleQuestionsByCategory[categoryId];
    notifyListeners();
  }

  generateCurrentQuestions(String categoryId) {
    _currentQuestions = repository.getRandom(
      _questions,
      categoryId,
      10,
      excluded: _latestQuestions,
    );
    _latestQuestions.addAll(_currentQuestions);
    _currentQuestion = _currentQuestions[0];
    notifyListeners();
  }

  setNextQuestion() {
    _currentQuestion = repository.getNext(_currentQuestions, _currentQuestion);
    notifyListeners();
  }

  answerQuestion(bool isValid) {
    _currentQuestion.isPassed = isValid;
    notifyListeners();
  }

  static QuestionModel of(BuildContext context) =>
      ScopedModel.of<QuestionModel>(context);
}
