import 'package:zgadula/models/question.dart';

enum CategoryModeType { show, talk, draw, sing, humming }

CategoryModeType nameToType(name) {
  switch (name) {
    case 'show':
      return CategoryModeType.show;
    case 'draw':
      return CategoryModeType.draw;
    case 'sing':
      return CategoryModeType.sing;
    case 'humming':
      return CategoryModeType.humming;
  }

  return CategoryModeType.talk;
}

class Category {
  final String id;
  final String name;
  final String image;
  final String description;
  final bool isFree;
  final List<CategoryModeType> modes;
  List<Question> questions;

  Category(
    this.id,
    this.name,
    this.image,
    this.description,
    this.isFree,
    this.modes,
    this.questions,
  );

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        description = json['description'],
        isFree = json['isFree'],
        modes =
            List.from((json['modes'] ?? []).map((mode) => nameToType(mode))),
        questions = List.from(json['questions'].map((name) => Question(name)));

  String getImagePath() {
    return 'assets/images/categories/$image';
  }
}
