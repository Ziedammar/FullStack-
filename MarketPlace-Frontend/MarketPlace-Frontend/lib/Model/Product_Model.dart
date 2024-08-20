class Product {
  int? prix;
  String? description;
  String? marque;
  String? categories;

  int? id_Image;

  Product(
      {required this.id_Image,
      required this.prix,
      required this.description,
      required this.marque,
      required this.categories});

  Product.fromJson(Map<String, dynamic> json) {
    marque = json['name'];
    description = json['description'];
    prix = json['prix'];
    id_Image = json['image'];
    categories = json['categories'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': 0,
      'name': marque,
      'Description': description,
      'prix': prix,
      'categories': categories,
      'image': id_Image
    };
  }
}
