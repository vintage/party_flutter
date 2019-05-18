import 'package:zgadula/models/question.dart';

class Category {
  final String id;
  final String name;
  final String image;
  final String description;
  List<Question> questions;

  Category(
    this.id,
    this.name,
    this.image,
    this.description,
    this.questions,
  );

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        description = json['description'],
        questions = List.from(
            json['questions'].map((name) => Question(name, json['name'])));

  String toString() {
    return name;
  }

  String getImagePath() {
    return 'assets/images/categories/$image';
  }
}
