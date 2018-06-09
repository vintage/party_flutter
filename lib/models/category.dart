import 'package:zgadula/models/question.dart';

class Category {
  final String id;
  final String name;
  final String image;
  final String description;
  final bool isFree;
  final List<Question> questions;

  Category(this.id, this.name, this.image, this.description, this.isFree,
      this.questions);

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        description = json['description'],
        isFree = json['isFree'],
        questions = new List<Question>.from(json['questions'].map((name) => new Question(name)));

  String getImagePath() {
    return 'assets/images/categories/$image';
  }
}
