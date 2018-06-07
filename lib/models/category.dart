class Category {
  final String id;
  final String name;
  final String image;
  final String description;
  final bool isFree;

  Category(this.id, this.name, this.image, this.description, this.isFree);

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        description = json['description'],
        isFree = json['isFree'];
}