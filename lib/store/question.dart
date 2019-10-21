import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:zgadula/models/question.dart';
import 'package:zgadula/repository/question.dart';
import 'package:zgadula/store/store.dart';

const QUESTIONS_PER_GAME = 10;

class QuestionModel extends StoreModel {
  QuestionRepository repository;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Map<String, List<Question>> _questions = {};
  Map<String, List<Question>> get questions => _questions;

  List<Question> _currentQuestions = [];
  List<Question> get currentQuestions => _currentQuestions;
  List<Question> get questionsAnswered =>
      _currentQuestions.where((q) => q.isPassed != null).toList();
  List<Question> get questionsPassed =>
      questionsAnswered.where((q) => q.isPassed).toList();
  List<Question> get questionsFailed =>
      questionsAnswered.where((q) => !q.isPassed).toList();
  List<Question> _latestQuestions = [];
  List<Question> get latestQuestions => _latestQuestions;

  Question _currentQuestion;
  Question get currentQuestion => _currentQuestion;

  QuestionModel(this.repository);

  load(String languageCode) async {
    _isLoading = true;
    notifyListeners();

    _questions = await repository.getAll(languageCode);
    _isLoading = false;
    notifyListeners();
  }

  generateCurrentQuestions(String categoryId) {
    _currentQuestions = repository.getRandom(
      _questions,
      categoryId,
      QUESTIONS_PER_GAME,
      excluded: _latestQuestions,
    );
    _currentQuestions.forEach((q) {
      q.isPassed = null;
    });
    _latestQuestions.addAll(_currentQuestions);
    _currentQuestion = _currentQuestions[0];
    notifyListeners();
  }

  isPreLastQuestion() {
    var nextQuestion = repository.getNext(_currentQuestions, _currentQuestion);
    if (nextQuestion == null) {
      return false;
    }

    return repository.getNext(_currentQuestions, nextQuestion) == null;
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
