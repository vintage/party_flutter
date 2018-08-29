import 'package:zgadula/store/category.dart';
import 'package:zgadula/store/question.dart';
import 'package:zgadula/store/tutorial.dart';

void initializeStore() {
  CategoryModel().initialize();
  QuestionModel().initialize();
  TutorialModel().initialize();
}
